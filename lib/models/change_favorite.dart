class ChangeFavorite{
  bool? status;
  String? message;

  ChangeFavorite.FromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}