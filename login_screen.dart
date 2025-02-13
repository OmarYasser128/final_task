import 'dart:developer';

import 'package:final_project/auth_cubit.dart';
import 'package:final_project/auth_states.dart';
import 'package:final_project/product_cubit.dart';
import 'home.dart';
import 'package:final_project/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController ppasswordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          }
          if (state is LoginErrorState) {
            log(state.message);
          }
        },
        builder: (context, state) {
          return BlocBuilder<AuthCubit, AuthStates>(
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
                                labelText: "Email",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter your email",
                                hintStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                prefixIcon: Icon(Icons.mail_sharp),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              controller: mailController,
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
                                labelText: "Password",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter your password",
                                hintStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                prefixIcon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                              controller: ppasswordController,
                              obscuringCharacter: "*",
                            ),
                          ),
                        ],
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
                                  authCubit.login(data: {
                                    "email": mailController.text,
                                    "password": ppasswordController.text,
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF192841),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              "Register Now",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
