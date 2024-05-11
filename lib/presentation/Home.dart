import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HOME extends StatefulWidget {
  const HOME({super.key});

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

 List<String> imageList =[];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add a new user"),
                    content: SizedBox(
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: GestureDetector(
                                onTap: () async {
                                  final pickedfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedfile == null) {
                                    return;
                                  } else {
                                    File file = File(pickedfile.path);
                                    setState(() async {
                                      imageList = await uploadimage(file);
                                    });
                                  }
                                },
                                child:
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: imageList.isEmpty
                                      ? NetworkImage(
                                          "https://thumbs.dreamstime.com/b/person-icon-blue-round-button-illustration-isolated-167295301.jpg")
                                      : NetworkImage(imageList[0]),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "NAME",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: name,
                              decoration: InputDecoration(
                                  labelText: "NAME",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("AGE",
                                style: TextStyle(color: Colors.grey)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: age,
                              decoration: InputDecoration(
                                  labelText: "AGE",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CANCEL",
                              style: TextStyle(color: Colors.black))),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () async{
                            await FirebaseFirestore.instance.collection('user').add({
                              'image': imageList,
                              'name': name.text,
                              'age': age.text,
                            });
                            imageList = [];
                            name.clear();
                            age.clear();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  );
                },
              );
            },
            label: Icon(Icons.add)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Users lists",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),
              child: TextFormField(

              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('lib/image/otp.jpeg'),
                      ),
                      title: Text("NAME"),
                      subtitle: Text("AGE"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> uploadimage(File file) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString();
    firebase_storage.Reference ref = storage.ref().child("images/$timestamp");
    firebase_storage.UploadTask task = ref.putFile(file);
    await task;
    String downloadurl = await ref.getDownloadURL();
    imageList.add(downloadurl);
    return imageList;
  }
}
