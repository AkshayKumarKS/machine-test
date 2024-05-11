

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class HOME extends StatefulWidget {
  const HOME({super.key});

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {

  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Add a new user"),
            actions: [
              GestureDetector(
                  onTap: ()async{
                    final pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedfile == null) {
                      return;
                    }else {
                      File file = File(pickedfile.path);
                      setState(() async{
                        image = await uploadimage(file);
                      });
                    }
                  },
                  child: CircleAvatar(backgroundImage: AssetImage(""),)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("NAME"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(
                  labelText: "NAME",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero)
                  )
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("AGE"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(
                    labelText: "AGE",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                    )
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ElevatedButton(onPressed: () {
                  }, child: Text("CANCEL")),
                  ElevatedButton(onPressed: () {
                  }, child: Text("SAVE"))
                  ],
                ),
              )
            ],
          );
        },);
      }, label: Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Users lists",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage('lib/image/otp.jpeg'),),
                    title: Text("NAME"),
                    subtitle: Text("AGE"),
                  );
                },),
            )
          ],
        ),
      )
      ,
    );
  }
  Future<String?>uploadimage(File file) async{
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child("image/$timestamp");
    firebase_storage.UploadTask task = ref.putFile(file);
    await task;
    String downloadurl = (await ref.putFile(file)) as String;
    setState(() {
      image = downloadurl;
    });
    return image;
  }
}
