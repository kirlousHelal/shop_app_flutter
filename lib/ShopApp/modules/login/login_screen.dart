import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_myself/ShopApp/modules/login/cubit/cubit.dart';
import 'package:shop_app_myself/ShopApp/modules/login/cubit/states.dart';
import 'package:shop_app_myself/ShopApp/shared/components/components.dart';
import 'package:shop_app_myself/ShopApp/shared/network/local/cache_helper.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/constants/constants.dart';
import '../../shared/styles/colors.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginPostSuccessState) {
              if (state.loginModel!.status!) {
                token = state.loginModel!.data!.token!;
                CacheHelper.saveData(key: "token", value: token);
                navigateTo(
                    context: context, screen: ShopLayout(), goBack: false);
              } else {
                showToast(
                  message: state.loginModel!.message!,
                  state: ToastState.error,
                );
              }
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: const Text("Login Screen"),
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
                            "Login...",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "login to browse our hot offers...",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
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
                            isPassword: cubit.isPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.showPassword();
                              },
                              icon: Icon(cubit.isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter The Password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ConditionalBuilder(
                                condition: state is! LoginPostLoadingState,
                                builder: (context) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        cubit.postLoginData(
                                          email: emailController.text,
                                          password: passController.text,
                                        );
                                      }
                                    },
                                    child: const Text("Login"),
                                  );
                                },
                                fallback: (context) =>
                                    CircularProgressIndicator(
                                      color: defaultColor,
                                    )),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Text(
                                "Don't Have an Account?".toUpperCase(),
                              ),
                              const SizedBox(width: 15),
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context: context,
                                    screen: RegisterScreen(),
                                  );
                                },
                                child: Text(
                                  "register".toUpperCase(),
                                  style: TextStyle(color: defaultColor),
                                ),
                              ),
                            ],
                          )
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
