import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nvld_app/models/UserModal.dart';
import 'package:nvld_app/screens/admin/admin.dart';

class Admin_addstaff extends StatefulWidget {
  const Admin_addstaff({Key? key}) : super(key: key);

  @override
  State<Admin_addstaff> createState() => _Admin_addstaffState();
}

class _Admin_addstaffState extends State<Admin_addstaff> {

  final _formKey = GlobalKey<FormState>();
    final emailEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.1,
          elevation: 0,
          backgroundColor: const Color.fromRGBO(118, 72, 216, 1),
          title: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: width * 0.006),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const CircleBorder(),
                padding: EdgeInsets.all(width * 0.005),
              ),
              child: Icon(
                Icons.person,
                size: height * 0.04,
                color: const Color.fromRGBO(88, 57, 178, 1),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Admin(),
                  ),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter the staff mail'),
                TextFormField(
                    controller: emailEditingController,
                    onSaved: (value) {
                      emailEditingController.text = value!;
                    },

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                SizedBox(height: 30),
                Text('Enter a password for mail'),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: passwordEditingController,
                  obscureText: true,

                  onSaved: (value) {
                    passwordEditingController.text = value!;
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      create(emailEditingController.text,
                          passwordEditingController.text);
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  final _auth = FirebaseAuth.instance;

  void create(String email, String password) async {
    late String errorMessage;
    try {
      UserCredential userCred=await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('this is user ID : ${userCred.user!.uid}');
      postDetailsToFirestore(userCred.user!.uid);
      //     .then((value) => {postDetailsToFirestore()})
      //     .catchError((e) {
      //   Fluttertoast.showToast(msg: e!.message);
      // });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      print(error.code);
    }
  }

  void postDetailsToFirestore(String uid) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = "";
    userModel.dob = "";
    userModel.userType="staff";

    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .set(userModel.toMap());

    print("came");
    Fluttertoast.showToast(msg: "Account created successfully! ");
  }
}
