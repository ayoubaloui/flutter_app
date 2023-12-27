import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/model/menu_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MenuService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> createMenu(
    MenuModel data,
  ) async {
    final DocumentReference docReference =
        FirebaseFirestore.instance.collection('menu').doc(
              data.id == '' ? null : data.id,
            );
    await docReference.set({
      'id': data.id ?? docReference.id,
      'menuImage': data.menuImage,
      'menuTitle': data.menuTitle,
      'menuPrice': data.menuPrice,
    });
  }

  Stream<List<MenuModel>> getAllData() {
    StreamController<List<MenuModel>> controller =
        StreamController<List<MenuModel>>();

    FirebaseFirestore.instance.collection('menu').snapshots().listen(
        (querySnapshot) {
      List<MenuModel> menuModel = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        menuModel.add(MenuModel.fromMap(data));
      }
      controller.add(menuModel);
    }, onError: (error) {
      // Handle any errors here
      if (kDebugMode) {
        print('Error getting menu list: $error');
      }
    });

    return controller.stream;
  }

  Future<void> deleteMenuDocument(String menuId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('menu').doc(menuId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<String> uploadImage(
      Uint8List imageData, String imageName, String imagePath) async {
    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg', // Change to the appropriate content type
    );

    final String fileName = imageName; // Change to the appropriate file name
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("$imagePath/$fileName");

    await ref.putData(imageData, metadata);

    // Retrieve the download URL
    final String downloadURL = await ref.getDownloadURL();
    if (kDebugMode) {
      print('File uploaded to Firestore. Download URL: $downloadURL');
    }
    return downloadURL;
  }
}
