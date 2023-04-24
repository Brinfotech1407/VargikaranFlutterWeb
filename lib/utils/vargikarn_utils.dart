import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
    int maxLine = 1,
    int minLines = 1,
    bool obscureText = false,
    bool readOnly = false,
    bool isMaxLength = false,
    int maxLength = 3,
    required double order,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: FocusTraversalOrder(
        order: NumericFocusOrder(order),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: controller,
          onTap: onTap,
          autofillHints: autofillHints,
          cursorColor: Colors.black,
          obscureText: obscureText,
          readOnly: readOnly,
          maxLines: maxLine,
          minLines: minLines,
          maxLength: isMaxLength ? maxLength : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              counterText: "",
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              focusColor: Colors.black,
              contentPadding: const EdgeInsets.only(left: 10, top: 18, bottom: 8),
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
                  color: Colors.red,
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
      ),
    );
  }

  Widget dropDownFormView(
      {required String? Function(String?)? validator,
      required List<DropdownMenuItem<String>>? item,
      required onChanged,
      required value}) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: DropdownButtonFormField<String>(
          isDense: true,
          elevation: 0,
          dropdownColor: Colors.white,
         focusColor: Colors.transparent,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              counterText: "",
              hintStyle: const TextStyle(fontSize: 14),
              focusColor: Colors.black,
              contentPadding: const EdgeInsets.only(left: 10, top: 18, bottom: 8),
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
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBorder: const OutlineInputBorder()),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          validator: validator,
          value: value,
          icon: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          items: item,
          onChanged: onChanged,
        ),
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

  Widget buildButtonView({required VoidCallback onTap, required String title}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 20),
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
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          )),
    );
  }

  void showAlertDialog({
    required BuildContext context,
    required String title,
    required String desc,
    required String confirmText,
    required QuickAlertType showAlertdialogType,
  }) {
    if (showAlertdialogType == QuickAlertType.warning) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: title,
          confirmBtnText: confirmText,
          text: desc);
    } else if (showAlertdialogType == QuickAlertType.info) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: title,
          confirmBtnText: confirmText,
          text: desc);
    } else if (showAlertdialogType == QuickAlertType.loading) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: title,
          confirmBtnText: confirmText,
          text: desc);
    } else if (showAlertdialogType == QuickAlertType.error) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: title,
          confirmBtnText: confirmText,
          text: desc);
    }
  }

  linearProgressView(progressValue) {
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
          value: progressValue,
        ),
        Text('${(progressValue * 100).round()}%'),
      ],
    );
  }
}
