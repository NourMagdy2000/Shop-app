import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/app_cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/app_cubit/shop_cubit/shop_states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_product.dart';
import 'package:shop/screens/shop_screens/specific_product_screen.dart';

class Product_screen extends StatelessWidget {
  const Product_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCuibt, Shop_states>(
      listener: (context, state) {
        if (state is ShopSucsessChangeFavoritesState) {
          if (!state.favoriteModel.status)

            showToast(
                message: state.favoriteModel.message, state: colorState.ERORR);

        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: shopCuibt.get(context).model != null &&
                shopCuibt.get(context).categoriesModel != null,
            builder: (context) => Product_builder(shopCuibt.get(context).model,
                shopCuibt.get(context).categoriesModel, context),
            fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )));
      },
    );
  }

  Widget Product_builder(
          Home_model? home_model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: home_model!.data.banners
                    .map((e) => Image(
                          image: NetworkImage("${e.image}"),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 220.0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel!.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 5.0,
                            ),
                        itemCount: categoriesModel!.data.data.length),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: 1 /1.85,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                children: List.generate(
                    home_model.data.products.length,
                    (index) => buildGridView(
                        home_model.data.products[index], context)),
              ),
            )
          ],
        ),
      );
  Widget buildCategoryItem(DataModel categoriesItem) => Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Image(
            image: NetworkImage('${categoriesItem.image}'),
            height: 100.0,
            width: 100.0,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(.8),
            child: Text(
              '${categoriesItem.name}',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          )
        ],
      );
  Widget buildGridView(Home_products home_products, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SpecificProductScreen(home_products)));},
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(
                      "${home_products.image}",
                    ),
                    height: 200.0,
                  ),
                  if (home_products.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    home_products.name,
                    style: TextStyle(height: 1.3, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      if (home_products.discount != 0)
                        Text(
                         " ${home_products.old_price.toInt().toString()} L.E",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              height: 1.2,
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        " ${home_products.price.toString()}  L.E",
                        style: TextStyle(
                            height: 1.2,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,

                      ),


                    ],
                  ),IconButton(
                      onPressed: () {
                        shopCuibt
                            .get(context)
                            .changeFavorites(home_products.id);
                      },
                      icon: shopCuibt
                          .get(context)
                          .favorites[home_products.id]!
                          ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : Icon(Icons.favorite_border))
                ],
              ),
            ),
          ],
        ),
      );
}
