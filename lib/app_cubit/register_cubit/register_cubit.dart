import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/login_cubit/login_states.dart';
import 'package:shop/app_cubit/register_cubit/register_states.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/end_point.dart';
import 'package:shop/network/remote/api/dio_helper.dart';

class register_cubit extends Cubit<register_states> {
  register_cubit() : super(ShopRegisterInitialState());
  IconData icon = Icons.visibility;
  bool isPassword2 = true;

  static register_cubit get(context) => BlocProvider.of(context);
  var email2Controller = TextEditingController();

  var password2Controller = TextEditingController();
  var phone2Controller = TextEditingController();
  var name2Controller = TextEditingController();

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegister2LoadingState());
    Dio_helper.postData(path: Register, data: {
      "email":email,
      "password":password,
     "phone":phone,
      "name":name
    }).then((value) {
      Login_model login = Login_model.fromJason(value.data);

      emit(ShopRegisterSuccessState(login));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility2() {
    isPassword2 = !isPassword2;
    isPassword2 ? icon = Icons.visibility_off : icon = Icons.visibility;
    emit(ShopRegisterChangePasswordIconState());
  }
}
