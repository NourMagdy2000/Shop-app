import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/Layout/layout.dart';
import 'package:shop/app_cubit/login_cubit/login_cubit.dart';
import 'package:shop/app_cubit/login_cubit/login_states.dart';
import 'package:shop/app_cubit/register_cubit/register_cubit.dart';
import 'package:shop/app_cubit/register_cubit/register_states.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/screens/register_screen.dart';

class Register_screen extends StatefulWidget {
  @override
  _Register_screenState createState() => _Register_screenState();
}

class _Register_screenState extends State<Register_screen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => register_cubit(),
      child: BlocConsumer<register_cubit, register_states>(
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.deepOrange)),
                      Text(
                        'Register now to browse our good offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.lightGreen),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.name,
                        c: register_cubit.get(context).name2Controller,
                        labeltext: 'Name',
                        prefixicon: Icon(Icons.person),
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.emailAddress,
                        c: register_cubit.get(context).email2Controller,
                        labeltext: 'Email',
                        prefixicon: Icon(Icons.email),
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          c: register_cubit.get(context).password2Controller,
                          obscure: register_cubit.get(context).isPassword2,
                          obscureText: "*",
                          suffix: register_cubit.get(context).icon,
                          suffixOnpressed: () {
                            register_cubit
                                .get(context)
                                .changePasswordVisibility2();
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
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.phone,
                        c: register_cubit.get(context).phone2Controller,
                        labeltext: 'phone',
                        prefixicon: Icon(Icons.phone),
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: states is! ShopRegister2LoadingState,
                        builder: (context) => Center(
                          child: buttom(color: Colors.orange,
                              text: 'REGISTER',fontSize: 18.0,width: 250.0,height: 50.0,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  register_cubit.get(context).userRegister(
                                      name: register_cubit
                                          .get(context)
                                          .name2Controller
                                          .text,
                                      phone: register_cubit
                                          .get(context)
                                          .phone2Controller
                                          .text,
                                      email: register_cubit
                                          .get(context)
                                          .email2Controller
                                          .text,
                                      password: register_cubit
                                          .get(context)
                                          .password2Controller
                                          .text);
                                } else {}
                              }),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, states) {
          if (states is ShopRegisterSuccessState) {
            if (states.login_model2.status) {
              showToast(
                  message: states.login_model2.message,
                  state: colorState.SUCCSESS);
              Cache_helper.saveData(
                  key: 'token', value: states.login_model2.data!.token);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ShopLayout_screen()),
                  (route) => true);
            } else {
              showToast(
                  message: states.login_model2.message, state: colorState.ERORR);
            }
          }else{print('not register');
          print(register_cubit.get(context).email2Controller.text);}
        },
      ),
    );
  }
}
