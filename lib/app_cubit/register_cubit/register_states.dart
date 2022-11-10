import 'package:shop/models/login_model.dart';

abstract class register_states {}

class  ShopRegisterInitialState extends register_states {}
class  ShopRegister2LoadingState extends register_states {}
class  ShopRegisterSuccessState extends register_states {
  final Login_model login_model2;

  ShopRegisterSuccessState(this.login_model2);


}
class  ShopRegisterErrorState extends register_states {
  final String error ;
  ShopRegisterErrorState(this.error);

}
class  ShopRegisterChangePasswordIconState extends register_states {}