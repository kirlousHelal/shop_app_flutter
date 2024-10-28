import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/modules/login/login_screen.dart';
import 'package:shop_app_myself/ShopApp/shared/network/local/cache_helper.dart';
import 'package:shop_app_myself/ShopApp/shared/styles/colors.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          final userModel = cubit.userModel;
          if (userModel != null) {
            nameController.text = userModel.data?.name! as String;
            emailController.text = userModel.data?.email! as String;
            phoneController.text = userModel.data?.phone! as String;
          }

          return ConditionalBuilder(
            condition: userModel != null,
            builder: (context) {
              return settingsBuilder(cubit, context, state);
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        });
  }

  Widget settingsBuilder(ShopCubit cubit, context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                defaultTextForm(
                  controller: nameController,
                  label: "Name",
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter The Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                defaultTextForm(
                  controller: emailController,
                  label: "Email Address",
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter The Email Address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                defaultTextForm(
                  controller: phoneController,
                  label: "Phone",
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter The Phone";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                if (state is ProfilePutLoadingState)
                  LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    color: defaultColor,
                  ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      cubit.putUpdateProfileData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        // password: passController.text,
                      );
                    },
                    child: const Text("Update"),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      CacheHelper.remove(key: "token");
                      navigateTo(
                          context: context,
                          screen: LoginScreen(),
                          goBack: false);
                    },
                    child: const Text("LogOut"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
