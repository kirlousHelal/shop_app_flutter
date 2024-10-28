import 'package:shop_app_myself/ShopApp/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginShowPasswordState extends LoginStates {}

class LoginPostLoadingState extends LoginStates {}

class LoginPostSuccessState extends LoginStates {
  final UserModel? loginModel;
  LoginPostSuccessState({required this.loginModel});
}

class LoginPostErrorState extends LoginStates {}
