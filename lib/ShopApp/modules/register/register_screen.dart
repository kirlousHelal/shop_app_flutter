import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/modules/register/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/modules/register/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/shared/styles/colors.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterPostSuccessState) {
              if (state.loginModel!.status!) {
                token = state.loginModel!.data!.token!;
                CacheHelper.saveData(key: "token", value: token);
                navigateTo(
                    context: context,
                    screen: ShopLayout(
                      context: context,
                    ),
                    goBack: false);
              } else {
                showToast(
                  message: state.loginModel!.message!,
                  state: ToastState.error,
                );
              }
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text("Register Screen"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Register...",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "register to browse our hot offers...",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
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
                            controller: passController,
                            label: "Password",
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            isPassword: cubit.isPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.showPassword();
                              },
                              icon: Icon(cubit.isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter The Password";
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
                          Center(
                            child: ConditionalBuilder(
                                condition: state is! RegisterPostLoadingState,
                                builder: (context) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      if (formKey.currentState!.validate()) {
                                        cubit.postRegisterData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    child: const Text("Register"),
                                  );
                                },
                                fallback: (context) =>
                                    CircularProgressIndicator(
                                      color: defaultColor,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
