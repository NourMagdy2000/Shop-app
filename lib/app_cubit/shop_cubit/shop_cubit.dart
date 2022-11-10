import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/shop_cubit/shop_states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_product.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/end_point.dart';
import 'package:shop/network/remote/api/dio_helper.dart';
import 'package:shop/screens/shop_screens/categerios_screen.dart';
import 'package:shop/screens/shop_screens/favorites_screen.dart';
import 'package:shop/screens/shop_screens/product_screen.dart';
import 'package:shop/screens/shop_screens/settings_screen.dart';

import '../../models/cart_Details.dart';
import '../../models/cart_model.dart';
import '../../models/faviorite_model.dart';

class shopCuibt extends Cubit<Shop_states> {
  shopCuibt() : super(ShopInitialState());

  static shopCuibt get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    Product_screen(),
    Categories_screen(),
    Favorites_screen(),
    Setting_screen()
  ];
  Home_model? model;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeNavBarState());
  }

  Map<int, bool> favorites = {};
  Map<int, bool> inCart = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    Dio_helper.getData(path: Home, token: token).then((value) {
      model = Home_model.fromJason(value.data);
      model!.data.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
        inCart.addAll({element.id: element.in_cart});
      });
      emit(ShopSucsessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    Dio_helper.getData(path: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSucsessGetCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCategoriesState());
    });
  }

  FavoriteModel? favoriteModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    Dio_helper.postData(
            path: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      if (!favoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSucsessChangeFavoritesState(favoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    Dio_helper.getData(path: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSucsessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  CartModel? cartModel;
  void changeCart(int productId) {
    inCart[productId] = !inCart[productId]!;
    emit(ShopChangeCartState());
    Dio_helper.postData(
            path: CART, data: {'product_id': productId}, token: token)
        .then((value) {
      cartModel = CartModel.fromJason(value.data);
      getCartData();

      if (!cartModel!.status) {
        inCart[productId] = !inCart[productId]!;
      } else {
        getCartData();
      }
      emit(ShopSucsessChangeCartState(cartModel!));
    }).catchError((error) {
      inCart[productId] = !inCart[productId]!;
      emit(ShopErrorChangeCartState());
    });
  }

  CartDetails? cartDetails;
  void getCartData() {
    emit(ShopLoadingGetCartState());
    Dio_helper.getData(path: CART, token: token).then((value) {
      cartDetails = CartDetails.fromJson(value.data);

      emit(ShopSucsessGetCartState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCartState());
    });
  }

  Login_model? login_model;
  void getProfileData() {
    emit(ShopLoadingGetProfileState());
    Dio_helper.getData(path: PROFILE, token: token).then((value) {
      login_model = Login_model.fromJason(value.data);

      emit(ShopSucsessGetProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileState());
    });
  }

  void updateProfileData(
      {required String name, required String email, required String phone}) {
    emit(ShopUpdateProfileLoadingState());
    Dio_helper.putData(
        path: UPDATE_PROFILE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
          if(value.data['status']){
            login_model = Login_model.fromJason(value.data);

          }


      emit(ShopUpdateProfileSuccessState(login_model!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileErrorState());
    });
  }
}
