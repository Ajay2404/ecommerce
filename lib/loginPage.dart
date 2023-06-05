import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/dashBoard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController registerPassword = TextEditingController();

  String imagePath = "";

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(child: Text("LOGIN")),
                  Tab(child: Text("SIGNUP")),
                ],
              ),
            ),
            body: TabBarView(children: [
              //loginpage
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter Email"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Your Password",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String loginEmail = email.text;
                      String loginPassword = password.text;
                      Map map1 = {
                        "rEmail": loginEmail,
                        "rPassword": loginPassword,
                      };
                      var url = Uri.parse(
                          'https://ajay2404.000webhostapp.com/ApiCalling/login.php');
                      var response = await http.post(url, body: map1);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      Map ab = jsonDecode(response.body);

                      if (ab['result'] == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login Success")));
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const DashBoard();
                          },
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("User Not Found")));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 100, right: 100),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //  registerPage
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            final ImagePicker picker = ImagePicker();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        XFile? photo = await picker.pickImage(
                                            source: ImageSource.camera);
                                        setState(() {
                                          imagePath = photo!.path;
                                          status = true;
                                        });
                                      },
                                      child: Row(children: const [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Camera"),
                                        SizedBox(width: 130),
                                        Icon(Icons.camera_alt),
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final XFile? image =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);
                                        setState(() {
                                          imagePath = image!.path;
                                          status = true;
                                        });
                                      },
                                      child: Row(children: const [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Gallery"),
                                        SizedBox(width: 136),
                                        Icon(Icons.image),
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: imagePath != ""
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(imagePath)),
                                  maxRadius: 80,
                                )
                              : const CircleAvatar(
                                  maxRadius: 80,
                                  child: Icon(
                                    Icons.person,
                                    size: 150,
                                  ))),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 170,
                            child: TextField(
                              controller: firstName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: "First Name",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 170,
                            child: TextField(
                              controller: lastName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: "Last Name",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: registerEmail,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Enter Your Email",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Enter Your Number",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: registerPassword,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Enter Your Password",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          String fName = firstName.text;
                          String lName = lastName.text;
                          String rEmail = registerEmail.text;
                          String numb = number.text;
                          String registerPass = registerPassword.text;
                          String imageData = "";
                          if (imagePath != "") {
                            List<int> img = File(imagePath).readAsBytesSync();
                            imageData = base64Encode(img);
                          }

                          Map map = {
                            "fName": fName,
                            "lName": lName,
                            "rEmail": rEmail,
                            "num": numb,
                            "rPassword": registerPass,
                            'imagedata': imageData,
                          };
                          var url = Uri.parse(
                              'https://ajay2404.000webhostapp.com/ApiCalling/register.php');
                          var response = await http.post(url, body: map);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          Map mm = jsonDecode(response.body);

                          if (mm['result'] == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("User Login Success")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("User already exist")));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 100, right: 100),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
            ])));
  }
}
