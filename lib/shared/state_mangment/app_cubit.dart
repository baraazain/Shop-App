import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorite.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/models/login_models.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/shared_preferance.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Map<int?, bool?> favorites = {};
  int currentIndex = 0;

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(ShowBottomState());
  }

  HomeModel? productModel;

  void getProduct() {
    emit(HomeLoadingState());
    DioHelper.getData(url: homeUrl,lang: language, token: token).then((value) {
      productModel = HomeModel.FromJson(value.data);
      productModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error));
    });
  }

  CategoryModel? categoryModel;
  void getCategory() {
    emit(CategoryLoadingState());
    DioHelper.getData(url: categoryUrl,lang: language).then((value) {
      categoryModel = CategoryModel.FromJson(value.data);
      if(categoryModel!=null){
        print('----');
        emit(CategorySuccessState());
      }

    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrorState(error));
    });
  }


  LoginModel? userModel;
  void getProfile() {
    emit(ProfileLoadingState());
    DioHelper.getData(url: profileUrl,lang:language ,token:token).then((value) {
      userModel = LoginModel.FromJson(value.data);
        emit(ProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorState(error));
    });
  }


  ChangeFavorite? changeFavorite;
  void addFavorite(int? id) {
    if (favorites[id] != null) {
      if (favorites[id] == true) {
        favorites[id] = false;
      }
      else
        favorites[id] = true;
    }
    emit(SetFavoriteLoadingState());
    DioHelper.postData(url: setFavoriteUrl,lang: language, token: token, data: {
      'product_id': id
    }).then((value) {
      changeFavorite = ChangeFavorite.FromJson(value.data);
      if (changeFavorite!.status == false) {
        if (favorites[id] != null) {
          if (favorites[id] == true) {
            favorites[id] = false;
          }
          else
            favorites[id] = true;
        }
      }
      getFavorite();
      emit(SetFavoriteSuccessState(changeFavorite!));
    }).catchError((error) {
      print(error.toString());
      if (favorites[id] != null) {
        if (favorites[id] == true) {
          favorites[id] == false;
        }
        else
          favorites[id] == true;
      }
      emit(SetFavoriteErrorState(error));
    });
  }


  FavoriteModel? favoriteModel;
  void getFavorite() {
    emit(FavoriteLoadingState());
    DioHelper.getData(url: setFavoriteUrl,lang: language, token: token).then((value) {
      favoriteModel = FavoriteModel.FromJson(value.data);
        emit(FavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FavoriteErrorState(error));
    });
  }



ChangeFavorite? updateProfileData;
  void updateProfile({
    required String email,
    required String phone,
    required String name,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: updateProfileUrl, lang: language,token: token, data: {
      'email': email,
      'name': name,
      'phone': phone,
    }).then((value) {
      updateProfileData=ChangeFavorite.FromJson(value.data);
      emit(UpdateProfileSuccessState(updateProfileData!));
      getProfile();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProfileErrorState(error.toString()));
    });
  }


  SearchModel? searchModel;
  void searchProduct(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: searchUrl, lang:language,token: token, data: {
      'text': text,
    }).then((value) {
      searchModel=SearchModel.FromJson(value.data);
        emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }


  bool isDark=CacheHelper.getData(key:'isDark')??false;
  void changeThemeMode(bool value){
    isDark =value;
    CacheHelper.saveData(key: 'isDark', value: isDark);
    emit(ThemeModeState());
  }

  String language=CacheHelper.getData(key:'lang')??'en';
  void changeLanguage(bool value){
    if(value)
    language ='ar';
    else
      language ='en';
    languageType=language;
    CacheHelper.saveData(key: 'lang', value:language);
    emit(LanguageState());
    getProduct();
    getCategory();
    getFavorite();
    getProfile();

  }

}
