import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiClient {
  static ApiClient? _instance;
  static const BASE_URL = "https://api.quotable.io/random";

  factory ApiClient() => _instance ??= new ApiClient._();

  ApiClient._();

  Future<http.Response> getMethodWithoutHeader() async {
    log(BASE_URL);
    var response = await http.get(
      Uri.parse(BASE_URL),
    );
    log(response.body);
    return response;
  }
}

Widget customTextFormField(
    {required BuildContext context,
    required String hintText,
    required String labelText,
    required bool readOnly,
    TextInputType? keyboard,
    TextEditingController? controller,
    Widget? icon,
    Function()? onTap,
    String? validatorString,
    String? prefixText,
    String? suffixText,
    bool? enabled,
    int? maxLength,
    int? maxLines,
      FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
    Key? key}) {
  return TextFormField(
    key: key,
    onChanged: onChanged,
    validator: validator,
    minLines: 1,
    maxLines: maxLines,
    onTap: onTap,
    enabled: enabled,
    readOnly: readOnly,
    keyboardType: keyboard,
    maxLength: maxLength,
    controller: controller,
    style: Theme.of(context).textTheme.caption,
    decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).splashColor),
            borderRadius: BorderRadius.circular(15),
            gapPadding: 8),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).errorColor),
            borderRadius: BorderRadius.circular(15),
            gapPadding: 8),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).errorColor),
            borderRadius: BorderRadius.circular(15),
            gapPadding: 8),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Theme.of(context).splashColor),
            borderRadius: BorderRadius.circular(15),
            gapPadding: 8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15),
            gapPadding: 8),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15),
            gapPadding: 8),
        prefixText: prefixText,
        prefixStyle: Theme.of(context).textTheme.bodyText1,
        suffixText: suffixText,
        suffixStyle: Theme.of(context).textTheme.bodyText1,
        hintText: hintText,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        helperStyle: Theme.of(context).textTheme.subtitle1,
        suffixIcon: icon,
        hintStyle: Theme.of(context).textTheme.subtitle1),
  );
}
