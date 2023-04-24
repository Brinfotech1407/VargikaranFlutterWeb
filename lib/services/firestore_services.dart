import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vargikaran_web_app/model/admin_model.dart';
import 'package:vargikaran_web_app/model/files_model.dart';
import 'package:vargikaran_web_app/services/preference_service.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PreferenceService _preferenceService = PreferenceService();
  FirebaseAuth auth = FirebaseAuth.instance;

  RxList<DocumentSnapshot<Map<String, dynamic>>> myData =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();

  final int noOfRecords = 25;

  Future<String?> addFilesData(
      FileModel filesData, BuildContext context) async {
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

  Future<List<FileModel>?> getFilesData(int count) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> doc = (await _firestore
          .collection('Files')
          .limit(count)
          .orderBy('entryDate', descending: true)
          .get());

      if (doc.docs.isNotEmpty) {
        final List<FileModel> filesModel = doc.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
                FileModel.fromJson(e.data()))
            .toList();
        return filesModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AdminModel?> getUpdatedFileNo() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
      await _firestore.collection('Admin').doc('data').get();

      if (doc.exists) {
        try {
          final AdminModel adminModel = AdminModel.fromJson(doc.data()!);
          return adminModel;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<AdminModel?> setUpdatedFileNo(int count) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
      await _firestore.collection('Admin').doc('data').get();

      if (doc.exists) {
        try {
          final AdminModel adminModel = AdminModel.fromJson(doc.data()!);
          return adminModel;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
