import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/splashscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:widget_mask/widget_mask.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp( MaterialApp(
    theme: ThemeData(primaryColor: Colors.white),
    home:  const SplashScreen(),
  ));
}
class Celebrare extends StatefulWidget {
  const Celebrare({super.key});

  @override
  State<Celebrare> createState() => _CelebrareState();
}
class _CelebrareState extends State<Celebrare> {


  File? file;
  var counti = 0;
  var countb = 0;

  Future<File?> cuter(File photoa) async {
    final photo = await ImageCropper().cropImage(sourcePath: photoa.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]
    );
    if (photo != null) {
      return File(photo.path);
    }
    else {
      return File(photoa.path);
    }
  }


  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        content: SingleChildScrollView(
          child: ListBody(
            children:[
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      countb = 5;
                    });
                    Navigator.pop(context);
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                  child: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white,),),
              const Center(child: Text('Uploaded Image',
              style: TextStyle(
                color: Colors.black
              ),),),
              Image.file(File(file!.path)),
              ElevatedButton(onPressed: (){
              setState(() {
                countb = 5;
                Navigator.pop(context);
              });},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black
                  ),
                  child: const Text('Apply Image Masking',
                  style: TextStyle(
                    color: Colors.white
                  ),))
              ]
      )
    )
        );
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Add Image/Icon",
              style: TextStyle(
                  color: Colors.greenAccent
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Card(
                  borderOnForeground: true,
                  elevation: 40,
                  color: Colors.white,
                  child: Column(
                      children: [
                        const Text(
                          "Upload Image",
                          style: TextStyle(
                              color: Colors.greenAccent
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final photoa = await ImagePicker().pickImage(
                                  source: ImageSource.gallery);

                              final photo = await cuter(File(photoa!.path));
                              setState(() {
                                file = File(photo!.path);
                              });
                              _showMyDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent
                            ),
                            child: const Text(
                              "Choose from Device",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            )
                        ),

                        if(counti==0) Container(child: file != null? Image.file(File(file!.path)): null)
                        else if(counti==1)  Container(
                          color: Colors.black,
                          child: WidgetMask(
                                             blendMode: BlendMode.srcATop,
                                             childSaveLayer: true,
                                             mask: Image.file(File(file!.path)),
                                             child: const Image(image: AssetImage('assets/Custom dimensions 500x500 px.png'))),
                        )
                        else if(counti==2) Container(
                            color: Colors.black,
                          child: WidgetMask(
                                blendMode: BlendMode.srcATop,
                                childSaveLayer: true,
                                mask: Image.file(File(file!.path)),
                                child: const Image(image: AssetImage('assets/Custom dimensions 500x500 px (1).png'))),
                        )
                        else if(counti==3) Container(
                              color: Colors.black,
                          child: WidgetMask(
                                  blendMode: BlendMode.srcATop,
                                  childSaveLayer: true,
                                  mask: Image.file(File(file!.path)),
                                  child: const Image(image: AssetImage('assets/Custom dimensions 500x500 px (2).png'))),
                        )
                        else if(counti==4) Container(
                                color: Colors.black,
                          child: WidgetMask(
                                    blendMode: BlendMode.srcATop,
                                    childSaveLayer: true,
                                    mask: Image.file(File(file!.path)),
                            child: const Image(image: AssetImage('assets/Custom dimensions 500x500 px (3).png'))),
                        ),
                         if(countb!=0) const Center(child: Text('Apply Image Masking by choosing different shapes')),
                        if(countb!=0) SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      counti = 1;
                                    });
                                  }, child: const FaIcon(FontAwesomeIcons.solidCircle, color: Colors.black,)),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      counti = 2;
                                    });
                                  }, child: const FaIcon(FontAwesomeIcons.solidSquare, color: Colors.black,)),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      counti = 3;
                                    });
                                  }, child: const FaIcon(FontAwesomeIcons.solidRectangleList, color: Colors.black,)),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      counti = 4;
                                    });
                                  }, child: const FaIcon(FontAwesomeIcons.solidHeart, color: Colors.black,)),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      counti = 0;
                                    });
                                  }, child: const Text('Original')),
                            ],
                          ),
                        ),
                        if(countb!=0) ElevatedButton(onPressed:(){
                          setState(() {
                            countb = 0;
                          });
                        } , child: const Text('Use this Image'))
                      ]
                  )
              ),
            ),
          ),

    );
  }
}






