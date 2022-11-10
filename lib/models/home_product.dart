class Home_model {
  late bool status;
  late Home_data_model data;

  Home_model.fromJason(Map<String, dynamic> jason) {
    status = jason['status'];
    data = Home_data_model.fromJason(jason['data']);
  }
}

class Home_data_model {
  late List<Home_panners> banners = [];
  late List<Home_products> products = [];


  Home_data_model.fromJason(Map<String, dynamic> jason) {
    if (jason['banners'] != null)
      jason['banners'].forEach((element) {
        banners.add(Home_panners.fromJason(element));
      });
    if (jason['products'] != null)
      jason['products'].forEach((element) {
        products.add(Home_products.fromJason(element));
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Home_panners {
  late int id;
  late String image;
  late Null category;
  late Null product;

  Home_panners.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    image = jason['image'];
    category = jason['category'];
    product = jason['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    data['product'] = this.product;
    return data;
  }
}

class Home_products {
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  late String description;
  late List<dynamic> images;
  Home_products.fromJason(Map<String, dynamic> jason) {
    id = jason['id'];
    price = jason['price'];
    old_price = jason['old_price'];
    discount = jason['discount'];
    image = jason['image'];
    name = jason['name'];
    in_favorites = jason['in_favorites'];
    in_cart = jason['in_cart'];
    description = jason['description'];
    images = jason['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.old_price;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['in_favorites'] = this.in_favorites;
    data['in_cart'] = this.in_cart;
    return data;
  }
}
