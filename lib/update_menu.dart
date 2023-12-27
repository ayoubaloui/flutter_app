import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_flutter_app/model/menu_model.dart';
import 'package:test_flutter_app/service/menu_service.dart';

class UpdateMenuScreen extends StatefulWidget {
  final MenuModel menuModel;
  const UpdateMenuScreen({required this.menuModel, super.key});

  @override
  State<UpdateMenuScreen> createState() => _UpdateMenuScreenState();
}

class _UpdateMenuScreenState extends State<UpdateMenuScreen> {
  MenuService menuService = MenuService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Uint8List? imageData;
  bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: widget.menuModel.menuTitle);
    final TextEditingController priceController =
        TextEditingController(text: widget.menuModel.menuPrice);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Update menu"),
        backgroundColor: const Color(0xffDE3C3C),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  children: [
                    imageData != null
                        ? CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: MemoryImage(imageData!))
                        : Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.menuModel.menuImage,
                                  ),
                                  fit: BoxFit.cover),
                            )),
                    Positioned(
                      bottom: 5,
                      right: 20,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xffDE3C3C),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade200,
                          ),
                          onPressed: () async {
                            await pickImage();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: titleController,
                  validator: (value) => validateEmptyField(value),
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      hintText: "dish title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: priceController,
                  validator: (value) => validateEmptyField(value),
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      hintText: "dish price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isSubmitting
                  ? const CircularProgressIndicator(
                      color: Color(0xffDE3C3C),
                    )
                  : SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (imageData == null) {
                              setState(() {
                                isSubmitting = true;
                              });

                              menuService
                                  .createMenu(MenuModel(
                                      id: widget.menuModel.id,
                                      menuImage: widget.menuModel.menuImage,
                                      menuTitle: titleController.text,
                                      menuPrice: priceController.text))
                                  .then((value) => setState(() {
                                        isSubmitting = false;
                                        Navigator.pop(context);
                                      }));
                            } else if (imageData != null) {
                              setState(() {
                                isSubmitting = true;
                              });

                              String menuImageUrl =
                                  await menuService.uploadImage(imageData!,
                                      generateUniqueId(), "menu Images");
                              menuService
                                  .createMenu(MenuModel(
                                      id: widget.menuModel.id,
                                      menuImage: menuImageUrl,
                                      menuTitle: titleController.text,
                                      menuPrice: priceController.text))
                                  .then((value) => setState(() {
                                        isSubmitting = false;
                                        Navigator.pop(context);
                                      }));
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color(0xffDE3C3C)),
                            foregroundColor: const MaterialStatePropertyAll(
                                Color(0xffffffff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ))),
                        child: const Text("Update"),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmptyField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  Future<void> pickImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);

      // If user cancels the picker, show snackbar
      if (file == null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No image selected')));
      }
      imageData = await file?.readAsBytes();
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

// generate id for storing image
  String generateUniqueId() {
    Random random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const length = 8;

    String id = '';
    for (int i = 0; i < length; i++) {
      id += chars[random.nextInt(chars.length)];
    }

    return id;
  }
}
