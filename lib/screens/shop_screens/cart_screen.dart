import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/models/cart_Details.dart';

import '../../app_cubit/shop_cubit/shop_cubit.dart';
import '../../app_cubit/shop_cubit/shop_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCuibt, Shop_states>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
              Text(
                'My cart',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
        ),
        body: ConditionalBuilder(
          condition: state is! ShopLoadingGetCartState,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildCartItem(
                        shopCuibt
                            .get(context)
                            .cartDetails!
                            .data!
                            .cartItems![index],
                        context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: shopCuibt
                        .get(context)
                        .cartDetails!
                        .data!
                        .cartItems!
                        .length),
                SizedBox(
                  height: 15.0,
                ),
                myDivider(),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Sub total :",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${shopCuibt.get(context).cartDetails!.data!.subTotal}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total :",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                    Text("${shopCuibt.get(context).cartDetails!.data!.total}",style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600)),
                  ],
                )
              ]),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget buildCartItem(CartItems cartItems, context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(
                        "${cartItems.product!.image}",
                      ),
                      height: 100.0,
                    ),
                    if (cartItems.product!.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.red,
                        child: Text(
                          'Discount!',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                      )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${cartItems.product!.name}",
                      style: TextStyle(height: 1.3, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        if (cartItems.product!.discount != 0)
                          Text(
                            "${cartItems.product!.oldPrice}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                height: 1.2,
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "${cartItems.product!.price}",
                          style: TextStyle(
                              height: 1.2,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            shopCuibt
                                .get(context)
                                .changeCart(cartItems.product!.id!);
                          },
                          icon: Icon(Icons.remove_circle),
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}
