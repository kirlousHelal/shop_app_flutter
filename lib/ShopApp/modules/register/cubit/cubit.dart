import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/modules/register/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  void showPassword() {
    isPassword = !isPassword;
    emit(RegisterShowPasswordState());
  }

  UserModel? loginModel;

  void postRegisterData({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterPostLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then(
      (value) {
        loginModel = UserModel.fromJson(value?.data);
        print(value?.data);
        emit(RegisterPostSuccessState(loginModel: loginModel));
      },
    ).catchError((error) {
      print(" The Error Is${error.toString()}");
      emit(RegisterPostErrorState());
    });
  }
}
