class CategoryModel{
  bool? status;
  CategoryData? data;

  CategoryModel.FromJson(Map<String,dynamic> json){
    status=json['status'];
    data=CategoryData.FromJson(json['data']);

  }
}
class CategoryData{
  int? currentPage;
  List<Data>? data=[];

  CategoryData.FromJson(Map<String,dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data!.add(Data.FromJson(element));
    });
  }

}
class Data{
  int? id;
  String? name;
  String? image;

  Data.FromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];

  }
}