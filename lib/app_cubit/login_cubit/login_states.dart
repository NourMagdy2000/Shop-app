import 'package:shop/models/login_model.dart';

abstract class login_states {}

class  ShopLoginInitialState extends login_states {}
class  ShopLoginLoadingState extends login_states {}
class  ShopLoginSuccessState extends login_states {
  final Login_model loginModel;

  ShopLoginSuccessState(this.loginModel);


}
class  ShopLoginErrorState extends login_states {
  final String error ;
  ShopLoginErrorState(this.error);

}
class  ShopLoginChangePasswordIconState extends login_states {}
