import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_models.dart';
import 'package:shop_app/modules/categorie_screen.dart';
import 'package:shop_app/modules/favorite_screen.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/modules/setting_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/state_mangment/login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? model;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeShown() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginShownState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: loginUrl, lang: 'en', data: {
      'email': email,
      'password': password,
    }).then((value) {
     model=LoginModel.FromJson(value.data);
      emit(LoginSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}
