import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/shop_layout.dart';
import 'package:shop_app_myself/ShopApp/modules/login/login_screen.dart';
import 'package:shop_app_myself/ShopApp/modules/on_boarding/on_boarding.dart';
import 'package:shop_app_myself/ShopApp/shared/constants/constants.dart';
import 'package:shop_app_myself/ShopApp/shared/network/local/cache_helper.dart';
import 'package:shop_app_myself/ShopApp/shared/network/remote/dio_helper.dart';

import 'ShopApp/shared/styles/themes.dart';
import 'bloc_observer.dart';

Widget startScreen({context}) {
  if (CacheHelper.isExist(key: "onBoard")!) {
    return LoginScreen();
  }

  if (CacheHelper.isExist(key: "token")!) {
    token = CacheHelper.getData(key: "token");
    return ShopLayout(context: context);
  }

  return OnBoarding();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  Widget startScreen = OnBoarding();

  if (CacheHelper.isExist(key: "isDark")!) {
    isDark = CacheHelper.getData(key: "isDark");
  }

  if (CacheHelper.isExist(key: "onBoard")!) {
    startScreen = LoginScreen();
  }

  // if (CacheHelper.isExist(key: "token")!) {
  //   token = CacheHelper.getData(key: "token");
  //   startScreen = ShopLayout(
  //     context: context,
  //   );
  // }
  print(token);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final Widget startScreen;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ShopCubit();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          // themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: startScreen(context: context),
          // home: startScreen,
        ),
      ),
    );
  }
}
