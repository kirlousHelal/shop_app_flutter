import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/models/login_model.dart';
import 'package:shop_app_myself/ShopApp/modules/login/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/shared/network/remote/dio_helper.dart';
import 'package:shop_app_myself/ShopApp/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void showPassword() {
    isPassword = !isPassword;
    emit(LoginShowPasswordState());
  }

  UserModel? loginModel;

  void postLoginData({
    required String email,
    required String password,
  }) {
    emit(LoginPostLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then(
      (value) {
        loginModel = UserModel.fromJson(value?.data);
        print(value?.data);
        emit(LoginPostSuccessState(loginModel: loginModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(LoginPostErrorState());
    });
  }
}
