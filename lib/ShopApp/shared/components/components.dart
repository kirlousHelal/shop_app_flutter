import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required String label,
  required Icon prefixIcon,
  required FormFieldValidator<String>? validator,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  ValueChanged<String>? onSubmit,
  IconButton? suffixIcon,
  bool isPassword = false,
  String obscuringCharacter = '•',
}) {
  return TextFormField(
    decoration: InputDecoration(
      label: Text(label),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    ),
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    obscureText: isPassword,
    obscuringCharacter: obscuringCharacter,
  );
}

Future navigateTo({
  required context,
  required Widget screen,
  bool goBack = true,
}) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => goBack,
  );
}

Future<bool?> showToast({
  required String? message,
  ToastState state = ToastState.success,
}) =>
    Fluttertoast.showToast(
      msg: message ?? "nothing",
      backgroundColor: chooseColor(state),
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      fontSize: 20,
    );

enum ToastState { success, error, warning }

Color chooseColor(ToastState state) {
  switch (state) {
    case ToastState.success:
      return Colors.green;
    case ToastState.error:
      return Colors.red;
    case ToastState.warning:
      return Colors.amber;
  }
}
