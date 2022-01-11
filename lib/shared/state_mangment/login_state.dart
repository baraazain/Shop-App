import 'package:shop_app/models/login_models.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel model;

  LoginSuccessState(this.model);
}
class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}

class LoginShownState extends LoginStates{}
