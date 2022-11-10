import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/app_cubit/shop_cubit/shop_states.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/screens/login_screen.dart';
import '../../app_cubit/shop_cubit/shop_cubit.dart';

class Setting_screen extends StatelessWidget {
  const Setting_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCuibt, Shop_states>(
        builder: (context, state) {
        var  updatedNameController = TextEditingController();
          var updatedEmailController = TextEditingController();
          var  updatedPhoneController = TextEditingController();

          if (shopCuibt.get(context).login_model != null) {
            Login_model  profile = shopCuibt.get(context).login_model!;
            updatedEmailController.text = shopCuibt.get(context).login_model!.data!.email;
            updatedNameController.text = shopCuibt.get(context).login_model!.data!.name;
            updatedPhoneController.text = shopCuibt.get(context).login_model!.data!.phone;
          }

          return ConditionalBuilder(
              condition: shopCuibt.get(context).login_model != null,
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (state is ShopUpdateProfileLoadingState)
                            LinearProgressIndicator(),
                          Center(
                              child: Text(
                            'My settings',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w700),
                          )),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              c: updatedNameController,
                              labeltext: 'Nane',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'this field must be filled ! ';
                                } else
                                  return null;
                              },
                              prefixicon: Icon(Icons.person)),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              c: updatedEmailController,
                              labeltext: 'Email',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'this field must be filled ! ';
                                } else
                                  return null;
                              },
                              prefixicon: Icon(Icons.email)),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              c: updatedPhoneController,
                              labeltext: 'Phone',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'this field must be filled ! ';
                                } else
                                  return null;
                              },
                              prefixicon: Icon(Icons.phone)),
                          SizedBox(
                            height: 30.0,
                          ),
                          buttom(
                              color: Colors.orange,
                              height: 45.0,
                              width: 250.0,
                              fontSize: 18,
                              function: () {
                                shopCuibt.get(context).updateProfileData(
                                    name: updatedNameController.text,
                                    email: updatedEmailController.text,
                                    phone: updatedPhoneController.text);
                              },
                              text: 'UPDATE'),
                          SizedBox(
                            height: 20.0,
                          ),
                          buttom(
                              color: Colors.redAccent,
                              height: 40.0,
                              width: 200.0,
                              function: () {
                                Cache_helper.removeData(key: 'token')
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login_screen()),
                                      (route) => true);
                                }).catchError((error) {});
                              },
                              fontSize: 18,
                              text: 'LOG OUT')
                        ],
                      ),
                    ),
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {

          if(state is ShopUpdateProfileSuccessState){if(!state.login_model.status){showToast(message: state.login_model.message,state: colorState.ERORR);}}
        });
  }
}
