import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vargikaran_web_app/model/files_model.dart';
import 'package:vargikaran_web_app/services/preference_service.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PreferenceService _preferenceService = PreferenceService();
  FirebaseAuth auth = FirebaseAuth.instance;

  RxList<DocumentSnapshot<Map<String, dynamic>>> myData =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();

  Future<String?> addFilesData(FileModel filesData, BuildContext context) async {
    try {
      await _firestore
          .collection("Files")
          .doc(filesData.id)
          .set(filesData.toJson(), SetOptions(merge: true));
    } on Exception catch (e) {
      log('Exception $e');
    }
    return filesData.id;
  }

  Future<FileModel?> getFilesData(String uid) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> doc = (await _firestore
          .collection('Files')
          .where('id', isEqualTo: uid)
          .get());

      if (doc.docs.isNotEmpty) {
        final FileModel userModel = FileModel.fromJson(doc.docs.first.data());
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
