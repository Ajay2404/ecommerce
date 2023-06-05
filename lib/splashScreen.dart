import 'package:ecommerce/loginPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "E-Commerce App",
        style: TextStyle(color: Colors.white),
      )),
      backgroundColor: Colors.blue,
    );
  }
}
