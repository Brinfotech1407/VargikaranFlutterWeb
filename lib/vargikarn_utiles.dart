import 'package:flutter/material.dart';

class Utils{

  Widget textFormFiledView({
     TextEditingController? controller,
    required Iterable<String> autofillHints,
    required String hintText,
    required TextInputType textInputType,
    required TextInputType keyboardType,
    required Function(String? value) validator,
    suffixIcon,
    bool obscureText = false,
    bool readOnly = false,
    bool isMaxLength = false,
    int maxLength = 3,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        autofillHints: autofillHints,
        cursorColor: Colors.black,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLength: isMaxLength ? maxLength : null,
        decoration: InputDecoration(
          suffixIcon:suffixIcon,
            counterText: "",
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            focusColor: Colors.black,

            contentPadding: const EdgeInsets.only(left: 10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: const OutlineInputBorder()),
        keyboardType: keyboardType,
        validator: (String? value) {
          return validator(value);
        },
      ),
    );
  }


  Container buildRowText(String title) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 10, top: 14, bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}