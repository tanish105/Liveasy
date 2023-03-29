import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'otp_screen.dart';

class EnterMobile extends StatefulWidget {
  EnterMobile({Key? key}) : super(key: key);
  late String verify;
  @override
  State<EnterMobile> createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  String? phoneno;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please enter your mobile number",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "You'll receive a special code to verify next",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 60,
            ),
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 50),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                phoneno=phone.completeNumber;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await SmsAutoFill().listenForCode();
                try{
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${phoneno}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      print("Verification id is - ");
                      print(verificationId);
                      widget.verify = verificationId;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterOTP(phoneno!, widget.verify),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                }catch(e){
                  print(e);
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
