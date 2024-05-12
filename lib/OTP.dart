import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progect01/main.dart';
import 'package:progect01/presentation/screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

TextEditingController otp1 = TextEditingController();
TextEditingController otp2 = TextEditingController();
TextEditingController otp3 = TextEditingController();
TextEditingController otp4 = TextEditingController();
TextEditingController otp5 = TextEditingController();
TextEditingController otp6 = TextEditingController();

class _OTPState extends State<OTP> {
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
                      image: AssetImage("lib/image/otp.jpeg"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "OTP VERIFICATION",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Enter the verification code we just sent to your number"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 68,
                      width: 50,
                      child: TextField(
                        controller: otp1,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 68,
                      width: 50,
                      child: TextField(
                        controller: otp2,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 68,
                      width: 50,
                      child: TextField(
                        controller: otp3,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 68,
                      width: 50,
                      child: TextField(
                        controller: otp4,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 68,
                      width: 50,
                      child: TextField(
                        controller: otp5,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 68,
                      width: 50,
                      child: TextField(
                        controller: otp6,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text("Dont Ger OTP ? "),
                  TextButton(onPressed: () {}, child: Text("Resent OTP"))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: totalx.verify,
                              smsCode: otp1.text +
                                  otp2.text +
                                  otp3.text +
                                  otp4.text +
                                  otp5.text +
                                  otp6.text);
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HOME(),
                          ));
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setBool('islogged', true);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Verify")),
            )
          ],
        ),
      ),
    );
  }
}
