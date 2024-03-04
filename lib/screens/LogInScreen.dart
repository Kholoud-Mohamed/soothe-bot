import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mapfeature_project/helper/show_snack_bar.dart';
import 'package:mapfeature_project/widgets/customButton.dart';
import 'package:mapfeature_project/widgets/customTextField.dart';
import 'package:mapfeature_project/widgets/customdivider.dart';
import 'package:mapfeature_project/widgets/passwordfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                DividerImage(),
                const SizedBox(height: 35),
                Container(
                  height: 500,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xffF6F8F8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 210, top: 20),
                              child: Text(
                                'Hello !',
                                style: TextStyle(
                                    fontFamily: 'Langar',
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 29,
                                    color: Color.fromARGB(255, 128, 133, 134)),
                              ),
                            ),
                            Text(
                              'WELCOME BACK',
                              style: TextStyle(
                                fontFamily: 'Langar',
                                // fontWeight: FontWeight.bold,
                                fontSize: 29,
                                color: Color(0xff1F5D6B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomFormTextField(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: '  Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        PasswordField(
                          obscureText: true,
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: '  Password',
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            if (email != null) {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                  email: email!,
                                  actionCodeSettings: ActionCodeSettings(
                                    url:
                                        'https://your-app.firebaseapp.com/__/auth/action?mode=resetPassword',
                                  ),
                                );
                                showSnackBar(context,
                                    'Please check your email for password reset instructions.');
                              } catch (e, stackTrace) {
                                print('Error sending password reset email: $e');
                                print('Stack trace: $stackTrace');
                                showSnackBar(context,
                                    'An error occurred while sending password reset email.');
                              }
                            } else {
                              showSnackBar(context, 'Email Field is required');
                            }
                          },
                          child: const Text(
                            'Forgot Password ? ',
                            style: TextStyle(
                                fontFamily: 'Langar',
                                // fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff1F5D6B)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await loginUser();
                                Navigator.pushNamed(context, 'navigator',
                                    arguments: email);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'user-not-found') {
                                  showSnackBar(context, 'user not found');
                                } else if (ex.code == 'wrong-password') {
                                  showSnackBar(context, 'wrong password');
                                }
                              } catch (ex) {
                                print(ex);
                                showSnackBar(context, 'there was an error');
                              }

                              isLoading = false;
                              setState(() {});
                            } else {}
                          },
                          text: '    Log in    ',
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontFamily: 'Langar',
                                  color: Color.fromARGB(255, 136, 136, 136)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'signup');
                              },
                              child: const Text(
                                ' Sign up',
                                style: TextStyle(
                                  fontFamily: 'Langar',
                                  color: Color(0xff1F5D6B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
