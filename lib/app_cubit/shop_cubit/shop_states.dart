import 'package:shop/models/faviorite_model.dart';

import '../../models/cart_model.dart';
import '../../models/login_model.dart';

abstract class Shop_states{}

class ShopInitialState extends Shop_states{}
class ShopChangeNavBarState extends Shop_states{}
class ShopLoadingHomeDataState extends Shop_states{}
class ShopSucsessHomeDataState extends Shop_states{}
class ShopErrorHomeDataState extends Shop_states{}

////////////////////get categories states////////

class ShopSucsessGetCategoriesState extends Shop_states{}
class ShopErrorGetCategoriesState extends Shop_states{}


/////////////// change favorites states////////////////

class ShopChangeFavoritesState extends Shop_states{}
class ShopSucsessChangeFavoritesState extends Shop_states{
  ShopSucsessChangeFavoritesState(this.favoriteModel);
  late final FavoriteModel favoriteModel;


}
class ShopErrorChangeFavoritesState extends Shop_states{}

/////////////// get favorites states////////////////

class ShopSucsessGetFavoritesState extends Shop_states{}
class ShopErrorGetFavoritesState extends Shop_states{}
class ShopLoadingGetFavoritesState extends Shop_states{}


////////////////////// change cart states /////////////

class ShopSucsessChangeCartState extends Shop_states{
  final CartModel cartModel;
  ShopSucsessChangeCartState(this.cartModel);}

class ShopErrorChangeCartState extends Shop_states{}
class ShopChangeCartState extends Shop_states{}

//////////////////get cart data ////////////

class ShopSucsessGetCartState extends Shop_states{}
class ShopErrorGetCartState extends Shop_states{}
class ShopLoadingGetCartState extends Shop_states{}

//////////////////get profile data ////////////

class ShopSucsessGetProfileState extends Shop_states{}
class ShopErrorGetProfileState extends Shop_states{}
class ShopLoadingGetProfileState extends Shop_states{}

////////////// update profile states //////////////


class  ShopUpdateProfileErrorState extends Shop_states {}
class  ShopUpdateProfileLoadingState extends Shop_states {}
class  ShopUpdateProfileSuccessState extends Shop_states {
  final Login_model login_model;

  ShopUpdateProfileSuccessState(this.login_model);


}
