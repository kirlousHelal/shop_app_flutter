import 'package:shop_app_myself/ShopApp/models/get_categories_model.dart';
import 'package:shop_app_myself/ShopApp/models/home_model.dart';
import 'package:shop_app_myself/ShopApp/models/login_model.dart';

import '../../../models/get_favorites_model.dart';
import '../../../models/post_favorites_model.dart';
import '../../../models/post_search_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopChangeThemeModeState extends ShopStates {}

class HomeGetErrorState extends ShopStates {}

class HomeGetSuccessState extends ShopStates {
  final HomeModel? homeModel;

  HomeGetSuccessState({required this.homeModel});
}

class HomeGetLoadingState extends ShopStates {}

class CategoriesGetErrorState extends ShopStates {}

class CategoriesGetSuccessState extends ShopStates {
  final GetCategoriesModel? getCategoriesModel;

  CategoriesGetSuccessState({required this.getCategoriesModel});
}

class CategoriesGetLoadingState extends ShopStates {}

class FavoritesGetErrorState extends ShopStates {}

class FavoritesGetSuccessState extends ShopStates {
  final GetFavoritesModel? getFavoritesModel;

  FavoritesGetSuccessState({required this.getFavoritesModel});
}

class FavoritesGetLoadingState extends ShopStates {}

class FavoritesPostErrorState extends ShopStates {}

class FavoritesPostSuccessState extends ShopStates {
  final PostFavoritesModel? postFavoritesModel;

  FavoritesPostSuccessState({required this.postFavoritesModel});
}

class FavoritesPostLoadingState extends ShopStates {}

class SearchPostErrorState extends ShopStates {}

class SearchPostSuccessState extends ShopStates {
  final PostSearchModel? postSearchModel;

  SearchPostSuccessState({required this.postSearchModel});
}

class SearchPostLoadingState extends ShopStates {}

class ProfilePutErrorState extends ShopStates {}

class ProfilePutSuccessState extends ShopStates {
  final UserModel? userModel;

  ProfilePutSuccessState({required this.userModel});
}

class ProfilePutLoadingState extends ShopStates {}

class ProfileGetErrorState extends ShopStates {}

class ProfileGetSuccessState extends ShopStates {
  final UserModel? userModel;

  ProfileGetSuccessState({required this.userModel});
}

class ProfileGetLoadingState extends ShopStates {}
