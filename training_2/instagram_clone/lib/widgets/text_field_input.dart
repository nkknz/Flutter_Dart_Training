import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType});
  final TextEditingController textEditingController;
  final bool isPass; //if data is a password or not
  final String hintText;
  final TextInputType
      textInputType; //we need to show the input type if username/email

  @override
  Widget build(BuildContext context) {
    //we need to show the input type if username/email
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    ); //since border and focused border are the same

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      //obscureText: isPass - usually false and will only be true if the text editing controller is going to be a password
      //will make input into dots or not visible
      obscureText: isPass,
    );
  }
}
