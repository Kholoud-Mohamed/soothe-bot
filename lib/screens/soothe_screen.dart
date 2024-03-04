import 'package:flutter/material.dart';
import 'package:mapfeature_project/widgets/customButton.dart';

class sotheeScreen extends StatelessWidget {
  const sotheeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 94, 162, 187),
              Color.fromARGB(255, 234, 243, 243),
              Color.fromARGB(255, 229, 235, 235),
              Color.fromARGB(255, 198, 229, 230),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hi , I'm Soothe",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Langar',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F5D6B)),
              ),
              Image.asset(
                'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                height: 300,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              CustomButton(
                text: 'Get Started',
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Everyday Therapy in your hands',
                style: TextStyle(fontFamily: 'Langar'),
              ),
              const SizedBox(
                height: 8,
              ),
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
    );
  }
}
