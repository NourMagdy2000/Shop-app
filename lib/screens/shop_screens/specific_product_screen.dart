import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/app_cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/app_cubit/shop_cubit/shop_states.dart';

import '../../models/home_product.dart';

class SpecificProductScreen extends StatelessWidget {
  Home_products home_products;
  SpecificProductScreen(this.home_products);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCuibt, Shop_states>(
      listener: (context, state) {
        if (state is ShopSucsessChangeCartState) if (state.cartModel.status)
          showToast(
              message: state.cartModel.message, state: colorState.SUCCSESS);
        else
          showToast(message: state.cartModel.message, state: colorState.ERORR);
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text('Product Details')),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                      height: 300.0,
                      width: 400.0,
                      image: NetworkImage('${home_products.image}')),
                ),
                Text(
                  home_products.name,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    if (home_products.discount != 0)
                      Text(
                        "Was  ${home_products.old_price}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600),
                      ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      " ${home_products.price}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25.0,
                          color: Colors.deepOrange),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color:
                                shopCuibt.get(context).inCart[home_products.id]!
                                    ? Colors.red
                                    : Colors.orange,
                            borderRadius: BorderRadius.circular(25.0)),
                        height: 50.0,
                        width: 260.0,
                        child: MaterialButton(
                          onPressed: () {
                            shopCuibt.get(context).changeCart(home_products.id);
                          },
                          child: Text(
                            shopCuibt.get(context).inCart[home_products.id]!
                                ? 'Remove from cart'
                                : 'Add to cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          shopCuibt
                              .get(context)
                              .changeFavorites(home_products.id);
                        },
                        icon:
                            shopCuibt.get(context).favorites[home_products.id]!
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(Icons.favorite_border))
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),myDivider(),SizedBox(height: 10.0,),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 15.0,
                ),myDivider(),SizedBox(height: 10.0,),
                Text(
                  home_products.description,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
