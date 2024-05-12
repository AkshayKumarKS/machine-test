import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progect01/OTP.dart';
import 'package:progect01/presentation/screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCPaQgltDbRGzSYbipoXPlEphk3VJHgMUY",
    appId: "1:644227177567:android:d4dd70597310f38573cfea",
    messagingSenderId: "644227177567",
    projectId: "project01-76457",
    storageBucket: "project01-76457.appspot.com",
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

bool finalData = false;

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getLoggedData().whenComplete(() async {
      if (finalData == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => totalx(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HOME(),
            ));
      }
    });
    super.initState();
  }

  Future getLoggedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var obtainedData = preferences.getBool('islogged');
    setState(() {
      finalData = obtainedData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HOME();
  }
}

class totalx extends StatefulWidget {
  static String verify = '';

  const totalx({super.key});

  @override
  State<totalx> createState() => _totalxState();
}

TextEditingController phone = TextEditingController();
TextEditingController countrycode = TextEditingController();

authFunction(BuildContext context) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: countrycode.text + phone.text,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);

      // store the authentication status

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('islogged', true);
    },
    verificationFailed: (FirebaseAuthException error) {
      print(error);
    },
    codeSent: (String verificationId, int? forceResendingToken) async {
      totalx.verify = verificationId;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTP(),
          ));
    },
    codeAutoRetrievalTimeout: (verificationId) {
      print("Timeout");
    },
  );
}

class _totalxState extends State<totalx> {
  @override
  Widget build(BuildContext context) {
    countrycode.text = "+91";
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/image/billing.jpeg"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Enter Phone Number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 60,
                    child: TextField(
                      controller: countrycode,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          // labelText: "+91",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    child: TextField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Enter Phone Number",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero))),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "By Continuing,i agree to TotalX's Terms and conditions & Privacy policy",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    authFunction(context);
                  },
                  child: Text("Get OTP")),
            )
          ],
        ),
      ),
    );
  }
}
