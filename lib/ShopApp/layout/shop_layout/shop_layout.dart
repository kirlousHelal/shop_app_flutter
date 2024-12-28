import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  final BuildContext context;
  ShopLayout({super.key, required this.context}) {
    ShopCubit.get(context).getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Shop App"),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            // type: BottomNavigationBarType.fixed,
            onTap: (index) => cubit.changeBottomNav(index: index),
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
          ),
          body: IndexedStack(
            index: cubit.currentIndex,
            children: cubit.bottomScreens,
          ),
        );
      },
    );
  }
}
