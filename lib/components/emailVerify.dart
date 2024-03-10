import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../portfolio.dart';

// ignore: must_be_immutable
class EmailVerify extends StatefulWidget {
  EmailVerify({
    super.key,
  });

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String otp = '';
  bool isload = false;
  final TextEditingController _pinController1 = TextEditingController();
  final TextEditingController _pinController2 = TextEditingController();
  final TextEditingController _pinController3 = TextEditingController();
  final TextEditingController _pinController4 = TextEditingController();
  final TextEditingController _pinController5 = TextEditingController();
  final TextEditingController _pinController6 = TextEditingController();

  void _sendOTP() async {
    try {
      _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
    // try {
    //   // Generate a random 6-digit OTP

    //   for (var i = 0; i < 6; i++) {
    //     otp += (0 + Random().nextInt(9)).toString();
    //   }

    //   // Send the OTP via email
    //   // final smtpServer = gmail('ashutoshjaiswal3@outlook.com', 'Pass@3456');
    //   // final message = Message()
    //   //   ..from = const Address('ashutoshjaiswal3@outlook.com', 'Protfolio')
    //   //   ..recipients.add(widget.)
    //   //   ..subject = 'Verification OTP'
    //   //   ..text = 'Your OTP for verification: $otp';

    //   await send(message, smtpServer);

    //   print('OTP sent to ${widget.email}: $otp');
    // } catch (e) {
    //   print('Failed to send OTP: $e');
    // }
  }

  @override
  void initState() {
    _sendOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.purple400,
      body: Center(
        child: Container(
          width: context.screenWidth > 600
              ? context.screenWidth / 2
              : double.infinity,
          padding: const EdgeInsets.all(12.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Spacer(),
            const Text("Verify Your Email",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Vx.white)),
            const Text("Please enter 6-digit code sent to .",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Vx.white)),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildOTPTextField(_pinController1),
                      _buildOTPTextField(_pinController2),
                      _buildOTPTextField(_pinController3),
                      _buildOTPTextField(_pinController4),
                      _buildOTPTextField(_pinController5),
                      _buildOTPTextField(_pinController6),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isload = true;
                        });
                        // String userOtp = _pinController1.text +
                        //     _pinController2.text +
                        //     _pinController3.text +
                        //     _pinController4.text +
                        //     _pinController5.text +
                        //     _pinController6.text;
                        // print('Entered OTP: $otp');
                        //if (otp == userOtp) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Portfolio()));
                        //} else {
                        // toast(context, 'Incorrect OTP try later');
                        //}
                      }
                    },
                    child: const Text('Verify OTP'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Did'nt receive email |",
                        style: TextStyle(color: Vx.white, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "RESEND",
                          style: TextStyle(
                              fontSize: 15,
                              color: Vx.purple900,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  const HeightBox(10),
                  if (isload)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Vx.white,
                      ),
                    )
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "Privacy Policy- Terms & Conditions",
              style: TextStyle(color: Vx.white),
            ),
            const Text.rich(TextSpan(
                text: "Provided By ",
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                      text: "Shivani Bind",
                      style: TextStyle(fontWeight: FontWeight.w500))
                ]))
          ]),
        ),
      ),
    );
  }

  Widget _buildOTPTextField(TextEditingController controller) {
    return SizedBox(
      width: 40.0,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        validator: (v) {
          if (v!.isEmpty) {
            return "";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
