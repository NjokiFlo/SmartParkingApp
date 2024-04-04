
import 'dart:io'; // Import dart:io for File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;

  Future<void> _selectImageFromGallery() async {

    var status = await Permission.photos.status;

    if ( !status.isGranted) {
      await Permission.photos.request();
      status = await Permission.photos.status;
    }
    if (!status.isGranted) {
      final XFile? returnedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) return;
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }else{
      //show dialog
    }
  }

  Future<void> _selectImageFromCamera() async {
    var status = await Permission.camera.status;
    if( !status.isGranted){
      await Permission.camera.request();
      status = await Permission.camera.status;
    }
    if( !status.isGranted) {
      final XFile? returnedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnedImage == null) return;

      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Page",
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Payment",
                icon: Icon(Icons.payment),
              ),
              Tab(
                text: "Gallery",
                icon: Icon(Icons.image),
              ),
              Tab(
                text: "Camera",
                icon: Icon(Icons.camera),
              ),
            ],
          ),
        ),

        body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Mpesa Numer",
                            label: Text("Phone Number"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                          )
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Number Plate",
                            label: Text("Number Plate"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                          )
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter Slot Number",
                              label: Text("Slot Number"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                          )
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,

                        ),
                        child: Text(
                          "Make Payment",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _selectImageFromGallery();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,

                        ),
                        child: Text(
                          "Select Image from Gallery",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  _selectedImage != null ? Column(
                    children: [
                      Image.file(_selectedImage!,width: 300,height:300,),
                      ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text("Submit Image",
                          style: TextStyle(
                            color: Colors.white,
                          ),)),
                    ],
                  )
                      : Text("Please Select An Image",)
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _selectImageFromCamera();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,

                        ),
                        child: Text(
                          "Capture Image",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ),
                  const SizedBox(height: 20),
                  _selectedImage != null ? Column(
                    children: [
                      Image.file(_selectedImage!,width: 300,height: 300,),
                      ElevatedButton(onPressed: (){},
                          child: Text("Submit Image"))
                    ],
                  ) : Text("Please Select An Image")
                ],
              ),

          ]
          ),

      ),
      );

  }

