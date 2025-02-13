import 'dart:developer';

import 'package:final_project/auth_cubit.dart';
import 'package:final_project/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_states.dart';
import 'home.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHidden = true;
  bool isPasswordMatch = true;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validatePasswordConfirmation() {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        isPasswordMatch = false; // Set to false if passwords don't match
      });
      return false;
    }
    setState(() {
      isPasswordMatch = true; // Set to true if passwords match
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context,state){
            if(state is RegisterSuccessState)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
              }
            if (state is RegisterErrorState) {
              log(state.message);
            }
          },

        builder: (context, state) {
          AuthCubit authCubit = context.read<AuthCubit>();
          return Scaffold(
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              size: 30,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome back! Glad",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Text(
                          "to see you. Again!",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: state is RegisterLoadingState
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "UserName",
                                    hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  controller: nameController,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  controller: emailController,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  maxLength: 11,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    } else if (value.length != 11) {
                                      return "Phone number must be 11 digits";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your phone number",
                                    hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    counterText:
                                        "", // Hides default character count display
                                  ),
                                  controller: phoneNumberController,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field is required";
                                    }
                                    return null;
                                  },
                                  obscureText: isHidden,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    prefixIcon: Icon(Icons.lock_outline),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isHidden = !isHidden;
                                          });
                                        },
                                        icon: Icon(isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                  ),
                                  controller: passwordController,
                                  obscuringCharacter: "*",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field is required";
                                    }
                                    return null;
                                  },
                                  obscureText: isHidden,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "Confirm password",
                                    hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    prefixIcon: Icon(Icons.lock_outline),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isHidden = !isHidden;
                                          });
                                        },
                                        icon: Icon(isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                  ),
                                  controller: confirmPasswordController,
                                  obscuringCharacter: "*",
                                ),
                              ),
                              if (!isPasswordMatch)
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Passwords don't match",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                  ),
                                ),
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final registrationData = {
                                "email": emailController.text,
                                "password": passwordController.text,
                                "data":{
                                "userName": nameController.text,  // Flattened field
                                "phoneNumber": phoneNumberController.text, // Flattened field
                                "confirmPassword": confirmPasswordController.text }// Flattened field
                              };
                              authCubit.register(data: registrationData);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF192841),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
