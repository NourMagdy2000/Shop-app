import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/app_cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/screens/login_screen.dart';

Widget defaultFormField(
        {required TextEditingController c,
        required String labeltext,
        required Function validate,
         onSubmitted,
     suffix,
        prefixicon,
        TextInputType? type,
        bool obscure = false,
        String obscureText = '*',
        suffixOnpressed}) =>
    Container(
      height: 70,
      width: 400,
      child: TextFormField(
          validator: (value) {
            return validate!(value);
          },
          obscureText: obscure,
          obscuringCharacter: obscureText,
          keyboardType: type,
          controller: c,
            onChanged: onSubmitted,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              labelText: labeltext,
              prefixIcon: prefixicon,
              suffixIcon: IconButton(
                onPressed: suffixOnpressed,
                icon: Icon(suffix),
              ))),
    );

Widget buttom(
        {String? text,
        Function? function,
        Color? color,
        double? height,
        double? width,
        double? fontSize}) =>
    Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(12.0)),
      margin: EdgeInsets.only(left: 12),
      height: height,
      width: width,
      child: MaterialButton(
        child: Text(
          text ?? '',
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
        onPressed: () {
          function!();
        },
      ),
    );
Widget textbuttom({String? text, Function? function}) => TextButton(
      child: Text(
        text ?? "",
        style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        function!();
      },
    );

void showToast({required String message, colorState? state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: switchColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);
Color switchColor({@required colorState? state}) {
  if (state == colorState.SUCCSESS) {
    return Colors.green;
  } else if (state == colorState.WARNING) {
    return Colors.orangeAccent;
  } else
    return Colors.red;
}

Widget myDivider() => Divider(
      height: double.minPositive,
      thickness: 1.0,
      endIndent: 20.0,
      indent: 20.0,
    );

enum colorState { SUCCSESS, WARNING, ERORR }

void signOut(context) => TextButton(
      child: Text('signOut'),
      onPressed: () {
        Cache_helper.removeData(key: 'token').then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login_screen()),
              (route) => true);
        });
      },
    );

Widget buildProductItem( productData,context)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(
                "${productData.image}",
              ),
              height: 100.0,width: 100.0,
            ),
            if (productData.discount != 0)
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0,),
              Text(
                "${productData.name}",
                style: TextStyle(height: 1.3, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  if (productData.discount != 0)
                    Text(
                      "${productData.discount} L.E",
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
                    "${productData.price}  L.E",
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
                            .changeFavorites(productData.id!);
                      },
                      icon:
                      shopCuibt
                          .get(context)
                          .favorites[productData.id]!
                          ?
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : Icon(Icons.favorite_border))

                ],
              )
            ],
          ),
        ),
      ],
    ),
  ),
);
