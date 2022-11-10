class CartModel{

  late bool status;
  late String message;


CartModel.fromJason(Map<String,dynamic> jason){
  status=jason['status'];
  message=jason['message'];
}







}