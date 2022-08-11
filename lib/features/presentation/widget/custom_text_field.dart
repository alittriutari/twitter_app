import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.title,
      this.showTitle = false,
      this.maxLines = 1,
      this.obsecureText = false,
      this.inputType = TextInputType.text,
      this.textInputMaxLength})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;

  final bool showTitle;
  final int maxLines;
  final bool obsecureText;
  final TextInputType inputType;
  final int? textInputMaxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitle
            ? Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              )
            : const SizedBox(),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLength: textInputMaxLength,
          keyboardType: inputType,
          obscureText: obsecureText,
          controller: controller,
          maxLines: maxLines,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Colors.grey[200]),
        ),
      ],
    );
  }
}
