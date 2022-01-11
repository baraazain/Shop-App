import 'package:shop_app/models/home_models.dart';

class SearchModel {
  bool? status;
  DataSearch? data;

  SearchModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataSearch.FromJson(json['data']) : null;
  }
}

class DataSearch {
  List<ProductSearch>? data = [];
  DataSearch.FromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data!.add(ProductSearch.FromJson(v));
    });
  }
}



class ProductSearch {
  int? id;
 dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductSearch.FromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
