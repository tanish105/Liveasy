import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/enter_mobile.dart';
import 'package:liveasy/home.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOTP extends StatefulWidget {
  final String phoneno;
  final String verify;
  const EnterOTP(this.phoneno, this.verify, {super.key});

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  void initState() {
    _listenOtp();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print("Unregistered Listener");
    super.dispose();
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
    print("OTP Listen is called");
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code = "";
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify phone',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Code is sent to ${widget.phoneno}'),
            SizedBox(
              height: 15,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
            ),
            // PinFieldAutoFill(
            //   currentCode: code,
            //   decoration: BoxLooseDecoration(
            //       radius: Radius.circular(12),
            //       strokeColorBuilder: FixedColorBuilder(
            //           Color(0xFF8C4A52))),
            //   codeLength: 6,
            //   onCodeChanged: (code) {
            //     print("OnCodeChanged : $code");
            //     code = code.toString();
            //   },
            //   onCodeSubmitted: (val) {
            //     print("OnCodeSubmitted : $val");
            //   },
            // ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Didn't receive the code? ",
              style: TextStyle(color: Colors.grey),
            ),
            // Text(
            //   "Request again",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            MaterialButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '${widget.phoneno}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    print(widget.verify);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EnterOTP(widget.phoneno!, widget.verify),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: const Text(
                'Request again',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verify, smsCode: code);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Verify and continue"),
            ),
          ],
        ),
      ),
    );
  }
}
