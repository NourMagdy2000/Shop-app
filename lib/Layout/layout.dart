import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/app_cubit/shop_cubit/shop_states.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/screens/login_screen.dart';
import 'package:shop/screens/shop_screens/cart_screen.dart';
import 'package:shop/screens/shop_screens/search_screen.dart';

class ShopLayout_screen extends StatelessWidget {
  const ShopLayout_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      shopCuibt.get(context).getHomeData();
      return BlocConsumer<shopCuibt, Shop_states>(
        listener: (BuildContext context, states) {},
        builder: (BuildContext context, states) {
          var cubit = shopCuibt.get(context);
          return Scaffold(
              appBar: AppBar(backgroundColor: Colors.orange,
                actions: [IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                    icon: Icon(Icons.add_shopping_cart)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search_screen()));
                      },
                      icon: Icon(Icons.search))
                ],
                title: Text(
                  'Diamonda',
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.production_quantity_limits),
                      label: 'Products'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favoirtes'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Setting')
                ],
              ),
              body: cubit.bottomScreens[cubit.currentIndex]);
        },
      );
    });
  }
}
