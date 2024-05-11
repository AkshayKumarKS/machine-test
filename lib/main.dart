import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progect01/OTP.dart';

void main(){
 WidgetsFlutterBinding.ensureInitialized();
 Firebase.initializeApp(options: FirebaseOptions(
     apiKey: "AIzaSyCPaQgltDbRGzSYbipoXPlEphk3VJHgMUY",
     appId: "1:644227177567:android:d4dd70597310f38573cfea",
     messagingSenderId: "644227177567",
     projectId: "project01-76457"));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: totalx(),
    )
  );
}
class totalx extends StatefulWidget {
  const totalx({super.key});

  @override
  State<totalx> createState() => _totalxState();
}

class _totalxState extends State<totalx> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/image/billing.jpeg"),fit: BoxFit.fill)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Enter Phone Number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter Phone Number",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("By Continuing,i agree to TotalX's Terms and conditions & Privacy policy",style: TextStyle(fontWeight: FontWeight.w400),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OTP(),));
              }, child: Text("Get OTP")),
            )
          ],
        ),
      ),
    );
  }
}
