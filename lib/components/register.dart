import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/components/emailVerify.dart';
import 'package:portfolio/components/login.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/database/userService.dart';
import 'package:portfolio/model/user.dart';
import 'package:velocity_x/velocity_x.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoad = false;
  TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const Spacer(),
            const Text("Create protfolio Account",
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
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: dec("Username"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.text,
                      decoration: dec("Email"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 0.5),
                          label: const Text("Create password"),
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
                        } else if (!value.contains('@') &&
                            !value.contains('.')) {
                          return 'Invail email';
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
                          "I have account |",
                          style: TextStyle(color: Vx.white, fontSize: 15),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const Login())),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 15,
                                color: Vx.purple900,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoad = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: email.text, password: password.text);

                            await DatabaseService.savingUserData(UserModel(
                                name: name.text,
                                email: email.text,
                                desc:
                                    "I am beginner developer and newly joined with it.",
                                githubId: '',
                                linkedin: '',
                                facebook: '',
                                projects: [],
                                img: '',
                                skills: {},
                                education: {},
                                roles: [],
                                instagram: ''));
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EmailVerify()));
                          } catch (e) {
                            // Registration failed
                            toast(
                                context,
                                e
                                    .toString()
                                    .substring(e.toString().indexOf(']') + 1)
                                    .capitalized);
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
                        child: CircularProgressIndicator(color: Vx.purple200),
                      ),
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
