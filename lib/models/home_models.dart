class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.FromJson(Map<String,dynamic> json){
    status=json['status'];
    data=HomeDataModel.FromJson(json['data']);
  }

}

class HomeDataModel{
  List<Banners> banners=[];
  List<Product> products=[];

  HomeDataModel.FromJson(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners.add(Banners.FromJson(element));
    });
    json['products'].forEach((element){
      products.add(Product.FromJson(element));
    });
  }


}

class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic disCount;
  String? name;
  String? image;
  bool? inFavorite;
  bool? inCart;

  Product.FromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    disCount=json['discount'];
    name=json['name'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
    image=json['image'];
  }


}

class Banners{
  int? id;
  String? image;
  Banners.FromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];

  }
}