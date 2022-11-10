class FavoriteModel{

  late String message;
  late bool status;

FavoriteModel.fromJson(Map<String,dynamic> json){
  this.status=json['status'];
  this.message=json['message'];
}



}