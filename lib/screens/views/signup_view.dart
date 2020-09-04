import 'package:firebase_auth_with_get_state/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupView extends GetView<AuthController> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  final TextEditingController nameCon = TextEditingController();
  final GlobalKey<FormState> _fbKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        Status status = controller.status.value;
        // if (status == Status.loading) return CircularProgressIndicator();
        if (status == Status.error) return Text('Error on connection :(');
        return SafeArea(
          child: Form(
            key: _fbKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
              child: Center(
                child: ListView(
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      semanticsLabel: 'Acme Logo',
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Member Signup',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 45,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              // attribute: 'name',
                              controller: nameCon,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Name',
                              ),
                              // validators: [
                              //   FormBuilderValidators.required(
                              //       errorText: 'This field cannot be empty.'),
                              // ],
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              // attribute: 'email',
                              controller: emailCon,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Email',
                              ),
                              // validators: [
                              //   FormBuilderValidators.required(
                              //       errorText: 'This field cannot be empty.'),
                              // ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: TextField(
                              // attribute: 'password',
                              obscureText: true,
                              controller: passwordCon,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Password',
                              ),
                              // validators: [
                              //   FormBuilderValidators.required(
                              //       errorText: 'This field cannot be empty.'),
                              // ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (_fbKey.currentState.validate()) {
                            _fbKey.currentState.save();
                            controller.signup(
                                name: nameCon.text,
                                email: emailCon.text,
                                password: passwordCon.text);
                          }
                        },
                        child: status == Status.loading
                            ? CircularProgressIndicator()
                            : Text(
                                'SIGNUP',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                        color: Colors.blue[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/login');
                      },
                      child: Center(
                        child: Text(
                          'Sign in instead',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
