class CategoriesModel {
  late Null states;
  late CategoriesData data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    this.states = json['states'];
    this.data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  late int current_page;
  late List<DataModel> data = [];
  CategoriesData.fromJson(Map<String, dynamic> json) {
    this.current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.image = json['image'];
  }
}
