class FavoriteModel {
  bool? status;
  DataFavorit? data;

  FavoriteModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataFavorit.FromJson(json['data']) : null;
  }
}

class DataFavorit {
  List<FavoriteData>? data = [];

  DataFavorit.FromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data!.add(FavoriteData.FromJson(v));
    });
  }
}

class FavoriteData {
  int? id;
  ProductFavorite? product;

  FavoriteData.FromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =ProductFavorite.FromJson(json['product']);
  }
}

class ProductFavorite {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductFavorite.FromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
