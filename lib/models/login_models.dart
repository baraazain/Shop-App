class LoginModel{
   bool? status;
   String? message;
   UserData? data;
   LoginModel.FromJson(Map<String,dynamic> json){
     status=json['status'];
     message=json['message'];
     data=json['data']!=null?UserData.FromJson(json['data']):null;
   }
}

class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

    UserData.FromJson(Map<String,dynamic>json){
      id=json['id'];
      email=json['email'];
      name=json['name'];
      phone=json['phone'];
      image=json['image'];
      token=json['token'];
      points=json['points'];
      credit=json['credit'];
    }
}