import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class CategoriesScreen extends StatefulWidget {
  static const String routeName='/CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _fomKey=GlobalKey<FormState>();
  final FirebaseStorage _fStorage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController categoryController=TextEditingController();



  File? _image;
  String? imageName='';
  Uint8List webImage = Uint8List(8);
  Future<void> pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _image = selected;
          imageName = selected.path.split('/').last;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _image = File('a');
          imageName = image.name;


        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  uploadCategory()async{
    if(_fomKey.currentState!.validate()){
      print('Good boy');
      EasyLoading.show();
      final _uuid = const Uuid().v4();
      final ref=FirebaseStorage.instance.ref().child('categoriesImages').child(imageName!);
      if(kIsWeb){
        await ref.putData(webImage).whenComplete(()async{


          final imageUri=await ref.getDownloadURL();
          await FirebaseFirestore.instance.collection('Categories').doc(imageName).set({
            'image':imageUri,
            'category name':categoryController.text
          }).whenComplete(() {
            EasyLoading.dismiss();
            setState(() {
              _image=null;
            });

          });


        });


      }

    }else{
      print(' O Bad guy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _fomKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:_image!=null?Image.memory(webImage,fit: BoxFit.cover,):Center(
                          child: Text('Category'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow.shade900),
                          onPressed: () {
                            print('*****************');
                            pickImage();
                          },
                          child: Text('Upload Image')),
                    ],
                  ),
                ),
                Flexible(

                  child: SizedBox(
                    width: 170,
                    child: TextFormField(
                      controller: categoryController,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'please enter the category name';
                        }else{
                          return null;
                        }
                      },
                      decoration:InputDecoration(
                        labelText: 'Enter Category Name',
                        hintText: 'Enter Category Name',
                      ) ,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: Colors.yellow.shade900),
                    onPressed: () {
                      uploadCategory();
                    },
                    child: Text('SAVE')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
