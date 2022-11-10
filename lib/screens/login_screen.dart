import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/Layout/layout.dart';
import 'package:shop/app_cubit/login_cubit/login_cubit.dart';
import 'package:shop/app_cubit/login_cubit/login_states.dart';
import 'package:shop/network/end_point.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/screens/register_screen.dart';

class Login_screen extends StatefulWidget {
  @override
  _Login_screenState createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  var formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<login_cubit, login_states>(
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login',
                        style: TextStyle(  fontWeight: FontWeight.w600,color: Colors.deepOrange,fontSize: 45.0)
                          ),
                    Text(
                      'login now to browse our good offers',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.lightGreen,fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      c: login_cubit.get(context).usernameController,
                      labeltext: 'Email',
                      prefixicon: Icon(Icons.email),
                      validate: ( String value) {
                        if (value!.isEmpty

                        ) {
                          return ' this field cannot be empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                defaultFormField(
                    c: login_cubit.get(context).passwordController,
                    obscure: login_cubit.get(context).isPassword,
                    obscureText: "*",
                    suffix: login_cubit.get(context).icon,
                    suffixOnpressed: () {
                      login_cubit
                          .get(context)
                          .changePasswordVisibility();
                    },
                    labeltext: 'password',
                    validate: (String value) {
                      if (value.isEmpty) {
                        return ' this field cannot be empty';
                      }
                    },
                    type: TextInputType.visiblePassword,
                    prefixicon: Icon(Icons.lock)),
                    SizedBox(
                      height: 25,
                    ),
                    ConditionalBuilder(
                      condition: states is! ShopLoginLoadingState,
                      builder: (context) => Center(
                        child: buttom(color: Colors.orange,
                            height: 50,width: 280,
                            fontSize: 18,
                            text: 'LOGIN',
                            function: () {
                              if (formKey2.currentState!.validate()) {
                                login_cubit.get(context).userLogin(
                                    email: login_cubit
                                        .get(context)
                                        .usernameController
                                        .text,
                                    password: login_cubit
                                        .get(context)
                                        .passwordController
                                        .text);
                              } else {}
                            }),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator(color: Colors.redAccent,)),
                    ),
                    textbuttom(
                      text: 'Dont have an account? Register now',
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register_screen()),
                            (route) => false);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, states) {
        if (states is ShopLoginSuccessState) {
          if (states.loginModel.status) {
           showToast(message: states.loginModel.message,state: colorState.SUCCSESS);
           Cache_helper.saveData(key: 'token', value: states.loginModel.data!.token);
           token=Cache_helper.getData(key: 'token');
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ShopLayout_screen()), (route) => true);
          } else {

            showToast(message: states.loginModel.message,state: colorState.ERORR);

          }
        }
      },
    );
  }
}
