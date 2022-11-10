import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/app_cubit/shop_cubit/shop_states.dart';
import 'package:shop/models/categories_model.dart';

class Categories_screen extends StatelessWidget {
  const Categories_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCuibt, Shop_states>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => buildCatItem(shopCuibt.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) => Divider(
                height: double.minPositive,
                thickness: 1.0,
                endIndent: 20.0,
                indent: 20.0,
              ),
          itemCount: shopCuibt.get(context).categoriesModel!.data.data.length),
    );
  }

  Widget buildCatItem(DataModel dataModel) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image(
              height: 100.0,
              width: 100.0,
              image: NetworkImage(
                  '${dataModel.image}'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              '${dataModel.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
          ],
        ),
      );
}
