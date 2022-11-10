import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/models/favorites_model.dart';

import '../../app_cubit/shop_cubit/shop_cubit.dart';
import '../../app_cubit/shop_cubit/shop_states.dart';

class Favorites_screen extends StatelessWidget {
  const Favorites_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCuibt, Shop_states>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(condition: state is !ShopLoadingGetFavoritesState,
        builder:(context)=> ListView.separated(physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildProductItem(shopCuibt.get(context).favoritesModel!.data!.data![index].product,context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: shopCuibt.get(context).favoritesModel!.data!.data!.length),
    fallback:(context) =>Center(child: CircularProgressIndicator()),  ),
    );
  }

}
