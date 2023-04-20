import 'package:flutter/material.dart';

class Utils {
  Widget textFormFiledView({
    TextEditingController? controller,
     Iterable<String>? autofillHints,
    required String hintText,
     TextInputType? textInputType,
     TextInputType? keyboardType,
    required Function(String? value) validator,
    onTap,
    suffixIcon,
    int maxLine= 1,
    int minLines= 1,
    bool obscureText = false,
    bool readOnly = false,
    bool isMaxLength = false,
    int maxLength = 3,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        autofillHints: autofillHints,
        cursorColor: Colors.black,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxLine,
        minLines: minLines,
        maxLength: isMaxLength ? maxLength : null,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            counterText: "",
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            focusColor: Colors.black,
            contentPadding: const EdgeInsets.only(left: 10,top: 12),
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

  Widget buildButtonView() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(right: 10,left: 10,bottom: 20,top: 20),
      child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.blue.withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return Colors.blue.withOpacity(0.12);
                }
                return null; // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () {},
          child: const Text('TextButton',style: TextStyle(fontSize: 18),)),
    );
  }
}
