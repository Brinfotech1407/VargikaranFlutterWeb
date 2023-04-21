import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import 'vargikarn_utiles.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;


   checkLoginStatus(
      {required bool isAllDetailsFilled,required BuildContext context}) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));


    if (isAllDetailsFilled) {
      isLoggedIn.value = true;
    } else {
      // ignore: use_build_context_synchronously
      Utils().showAlertDialog(
          context:context,
          title: '',
          desc:'Invalid email or password.',
          confirmText:'Okay',
          showAlertdialogType: QuickAlertType.warning);
    }
  }
}
