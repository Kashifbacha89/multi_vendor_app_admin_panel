import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadBannersScreen extends StatefulWidget {
  static const String routeName = '/UploadBannersScreen';

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  final FirebaseStorage _fStorage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;



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


 _uploadBannersToStorage(String image)async{
    Reference ref= _fStorage.ref().child('Banners').child(imageName!);
    UploadTask uploadTask=ref.putData(webImage);

    TaskSnapshot snapshot=await uploadTask;
    String downloadUrl=await snapshot.ref.getDownloadURL();
    return downloadUrl;
 }
 uploadToFirestore()async{
    if(_image!=null){
      dynamic  imageUrl=_uploadBannersToStorage(webImage.toString());
      await _firestore.collection('banners').doc(imageName).set({
        'image':imageUrl,
      });
    }
 }
 _uploadBanners()async{
    EasyLoading.show();
   final _uuid = const Uuid().v4();
    final ref=FirebaseStorage.instance.ref().child('BannersImages').child(imageName!);
    if(kIsWeb){
      await ref.putData(webImage).whenComplete(()async{


        final imageUri=await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('Banners').doc(_uuid).set({
          'image':imageUri
        }).whenComplete(() {
          EasyLoading.dismiss();
          setState(() {
            _image=null;
          });

        });


      });


    }

 }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: Text(
              'Banners',
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
                      child: _image!=null?Image.memory(webImage,fit: BoxFit.cover,):Center(
                        child: Text('Banners'),
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
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.yellow.shade900),
                  onPressed: () {
                    print(imageName);
                    _uploadBanners();
                  },
                  child: Text('SAVE')),
            ],
          ),
          Divider(color: Colors.grey,),

        ],
      ),
    );
  }
}
