import 'package:shop_app_myself/ShopApp/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterShowPasswordState extends RegisterStates {}

class RegisterPostLoadingState extends RegisterStates {}

class RegisterPostSuccessState extends RegisterStates {
  final UserModel? loginModel;

  RegisterPostSuccessState({required this.loginModel});
}

class RegisterPostErrorState extends RegisterStates {}
