import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/components/emailVerify.dart';
import 'package:portfolio/components/register.dart';
import 'package:portfolio/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoad = false;
  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  dec(label) => InputDecoration(
      contentPadding: const EdgeInsets.only(top: 1),
      label: Text(
        label,
      ),
      labelStyle: const TextStyle(color: Vx.white));

  bool isVisible = true;

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
            const Text("Welcome back",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Vx.white)),
            const Text(
                "Use our gmail and password for login and start within pervious state.",
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
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.text,
                      decoration: dec("Email"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 0.5),
                          label: const Text("Password"),
                          labelStyle: const TextStyle(color: Vx.white),
                          suffix: IconButton(
                              splashRadius: 10,
                              onPressed: () => setState(() {
                                    if (isVisible) {
                                      isVisible = false;
                                    } else {
                                      isVisible = true;
                                    }
                                  }),
                              icon: Icon(
                                !isVisible
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: Colors.white,
                              ))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Did'nt have account |",
                          style: TextStyle(color: Vx.white, fontSize: 15),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Register())),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 15,
                                color: Vx.purple900,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoad = true;
                          });
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email.text, password: password.text);

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EmailVerify()));
                          } catch (e) {
                            toast(
                                context,
                                e
                                    .toString()
                                    .substring(e.toString().indexOf(']')));
                          } finally {
                            setState(() {
                              isLoad = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 45)),
                      child: const Text("Submit"),
                    ),
                    const HeightBox(10),
                    if (isLoad)
                      const Center(
                          child: CircularProgressIndicator(color: Vx.white))
                  ],
                )),
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
}
