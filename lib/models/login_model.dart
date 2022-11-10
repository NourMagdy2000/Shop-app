class Login_model {
  dynamic status;
  dynamic message;
   Login_user_data? data;
  Login_model.fromJason(Map<String, dynamic> jason) {
     status = jason['status'];
   message = jason['message'];
    data = jason['data']!=null?Login_user_data.fromJason(jason['data']):null;
  }
}

class Login_user_data {
   dynamic id;
  late String name;
   late  String email;
   late String phone;
   late String image;
   dynamic points;
   dynamic credit;
  late String token;

  Login_user_data.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    name = jason['name'];
    email = jason['email'];
    phone = jason['phone'];
    image = jason['image'];
    points = jason['points'];
    token = jason['token'];
  }
}
