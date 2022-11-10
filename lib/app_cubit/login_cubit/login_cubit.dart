import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/login_cubit/login_states.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/end_point.dart';
import 'package:shop/network/remote/api/dio_helper.dart';

class login_cubit extends Cubit<login_states> {
  login_cubit() : super(ShopLoginInitialState());
  IconData icon=Icons.visibility;
  bool isPassword=true;

  static login_cubit get(context) => BlocProvider.of(context);
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();



  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    Dio_helper.postData(
        path: Login,
        data: {'email': '${email}', 'password': '${password}'}).then((value) {

      Login_model login2=Login_model.fromJason(value.data);

      emit(ShopLoginSuccessState(login2));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });

  } void changePasswordVisibility(){
    isPassword=!isPassword;
    isPassword?icon=icon=Icons.visibility_off:icon=Icons.visibility;
    emit(ShopLoginChangePasswordIconState());
  }
}
