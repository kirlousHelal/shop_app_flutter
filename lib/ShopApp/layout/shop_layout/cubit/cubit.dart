import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/models/get_categories_model.dart';
import 'package:shop_app_myself/ShopApp/models/get_favorites_model.dart';
import 'package:shop_app_myself/ShopApp/models/home_model.dart';
import 'package:shop_app_myself/ShopApp/models/login_model.dart';
import 'package:shop_app_myself/ShopApp/models/post_search_model.dart';
import 'package:shop_app_myself/ShopApp/modules/bottom_screens/categories_screen.dart';
import 'package:shop_app_myself/ShopApp/modules/bottom_screens/favorites_screen.dart';
import 'package:shop_app_myself/ShopApp/modules/bottom_screens/home_screen.dart';
import 'package:shop_app_myself/ShopApp/modules/bottom_screens/search_screen.dart';
import 'package:shop_app_myself/ShopApp/modules/bottom_screens/settings_screen.dart';
import 'package:shop_app_myself/ShopApp/shared/components/components.dart';
import 'package:shop_app_myself/ShopApp/shared/network/local/cache_helper.dart';

import '../../../models/post_favorites_model.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded), label: "Search"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: "Favorites"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  List<Widget> bottomScreens = [
    HomeScreen(),
    const CategoriesScreen(),
    SearchScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  ScrollController homeScrollController = ScrollController();
  ScrollController categoryScrollController = ScrollController();
  ScrollController searchScrollController = ScrollController();
  ScrollController favoriteScrollController = ScrollController();

  void changeThemeMode() {
    isDark = !isDark;
    CacheHelper.saveData(key: "isDark", value: isDark);
    emit(ShopChangeThemeModeState());
  }

  void changeBottomNav({required int index}) {
    if (currentIndex == index) {
      setScroll(index: index, position: 0, controller: homeScrollController);
      setScroll(
          index: index, position: 1, controller: categoryScrollController);
      setScroll(index: index, position: 2, controller: searchScrollController);
      setScroll(
          index: index, position: 3, controller: favoriteScrollController);
      return;
    }

    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void setScroll(
      {required int index,
      required int position,
      required ScrollController controller}) {
    if (index == position) {
      controller!.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  Map<int?, bool?> favorites = {};

  HomeModel? homeModel;

  void getHomeData() {
    emit(HomeGetLoadingState());
    DioHelper.getData(url: HOME, token: token).then(
      (value) {
        homeModel = HomeModel.fromJson(value?.data);

        homeModel?.data?.products?.forEach(
          (element) {
            favorites.addAll({element.id: element.inFavorites});
          },
        );

        //print(value?.data);
        emit(HomeGetSuccessState(homeModel: homeModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(HomeGetErrorState());
    });
  }

  GetCategoriesModel? getCategoriesModel;

  void getCategoriesData() {
    emit(CategoriesGetLoadingState());
    DioHelper.getData(url: CATEGORIES, token: token).then(
      (value) {
        getCategoriesModel = GetCategoriesModel.fromJson(value?.data);
        //print(value?.data);
        emit(CategoriesGetSuccessState(getCategoriesModel: getCategoriesModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(CategoriesGetErrorState());
    });
  }

  PostFavoritesModel? postFavoritesModel;

  void postFavoritesData({
    required int productID,
  }) {
    emit(FavoritesPostLoadingState());
    favorites[productID] = !favorites[productID]!;
    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id": productID,
      },
      token: token,
    ).then(
      (value) {
        postFavoritesModel = PostFavoritesModel.fromJson(value?.data);
        if (postSearchModel?.status == false) {
          favorites[productID] = !favorites[productID]!;
          showToast(
              message: postFavoritesModel!.message, state: ToastState.error);
        } else {
          getFavoritesData();
        }
        //print(value?.data);
        emit(FavoritesPostSuccessState(postFavoritesModel: postFavoritesModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(FavoritesPostErrorState());
    });
  }

  GetFavoritesModel? getFavoritesModel;

  void getFavoritesData() {
    emit(FavoritesGetLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then(
      (value) {
        getFavoritesModel = GetFavoritesModel.fromJson(value?.data);
        //print(value?.data);
        emit(FavoritesGetSuccessState(getFavoritesModel: getFavoritesModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(FavoritesGetErrorState());
    });
  }

  UserModel? userModel;

  void getProfileData() {
    emit(ProfileGetLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then(
      (value) {
        userModel = UserModel.fromJson(value?.data);
        //print(value?.data);
        emit(ProfileGetSuccessState(userModel: userModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(ProfileGetErrorState());
    });
  }

  void putUpdateProfileData({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    emit(ProfilePutLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    }).then(
      (value) {
        userModel = UserModel.fromJson(value?.data);
        // if(userModel!.status!)
        //   {
        //     getProfileData();
        //   }
        //print(value?.data);
        emit(ProfilePutSuccessState(userModel: userModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(ProfilePutErrorState());
    });
  }

  PostSearchModel? postSearchModel;

  void postSearchData({
    required String text,
  }) {
    emit(SearchPostLoadingState());
    if (text.isEmpty) {
      postSearchModel = null;
      emit(SearchPostSuccessState(postSearchModel: postSearchModel));
      return;
    }
    DioHelper.postData(url: SEARCH, token: token, data: {
      "text": text,
    }).then(
      (value) {
        postSearchModel = PostSearchModel.fromJson(value?.data);
        // print(value?.data);
        emit(SearchPostSuccessState(postSearchModel: postSearchModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(SearchPostErrorState());
    });
  }

  void getAllData() {
    currentIndex = 0;
    homeModel = null;
    getCategoriesModel = null;
    postFavoritesModel = null;
    getFavoritesModel = null;
    userModel = null;
    postSearchModel = null;

    getHomeData();
    getProfileData();
    getFavoritesData();
    getCategoriesData();
  }
}
