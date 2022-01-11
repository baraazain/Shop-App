import 'package:shop_app/models/change_favorite.dart';

abstract class AppStates{}

class InitialState extends AppStates{}
class ShowBottomState extends AppStates{}
class ThemeModeState extends AppStates{}
class LanguageState extends AppStates{}



class HomeLoadingState extends AppStates{}
class HomeSuccessState extends AppStates{}
class HomeErrorState extends AppStates{
  final String error;

  HomeErrorState(this.error);
}



class CategoryLoadingState extends AppStates{}
class CategorySuccessState extends AppStates{}
class CategoryErrorState extends AppStates{
  final String error;

  CategoryErrorState(this.error);
}



class SetFavoriteLoadingState extends AppStates{}
class SetFavoriteSuccessState extends AppStates{
  final ChangeFavorite model;
  SetFavoriteSuccessState(this.model);
}
class SetFavoriteErrorState extends AppStates{
  final String error;
  SetFavoriteErrorState(this.error);
}



class FavoriteLoadingState extends AppStates{}
class FavoriteSuccessState extends AppStates{}
class FavoriteErrorState extends AppStates{
  final String error;
  FavoriteErrorState(this.error);
}


class ProfileLoadingState extends AppStates{}
class ProfileSuccessState extends AppStates{}
class ProfileErrorState extends AppStates{
  final String error;
  ProfileErrorState(this.error);
}



class UpdateProfileLoadingState extends AppStates{}
class UpdateProfileSuccessState extends AppStates{
  final ChangeFavorite model;

  UpdateProfileSuccessState(this.model);
}
class UpdateProfileErrorState extends AppStates{
  final String error;
  UpdateProfileErrorState(this.error);
}




class SearchLoadingState extends AppStates{}
class SearchSuccessState extends AppStates{}
class SearchErrorState extends AppStates{
  final String error;
  SearchErrorState(this.error);
}