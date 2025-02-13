import 'package:final_project/home_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedindex=0;

  final List screens=[
    ProfileScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:

      Column(
        children: [
          SizedBox(height: 40,),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/128/1946/1946429.png"),
                  backgroundColor: Colors.black38,
                ),
                Positioned(
                  bottom: 5,
                  right: 20,
                  child:
                  CircleAvatar(radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(onPressed: () {}, icon: Icon(
                        Icons.camera_alt)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text("User Name : ", style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,),)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text("Email : ", style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,),)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(alignment: Alignment.centerLeft,
                    child: Text("Phone Number: ", style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,),)),
              ),
            ),
          ),
          SizedBox(height: 80,),
        ],
      ),

    );
  }
}