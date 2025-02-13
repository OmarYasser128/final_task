import 'dart:developer';

import 'package:final_project/auth_cubit.dart';
import 'package:final_project/auth_states.dart';
import 'package:final_project/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_states.dart';
import 'product_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // List of screens to switch between
  final List<Widget> _screens = [
    HomePage(),
    ProfilePage(),
  ];

  // Change screen when tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display selected screen

      // Add the Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.deepPurple[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home Page Screen
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
          );
        }
        if (state is LogoutErrorState) {
          log(state.errMsg);
        }
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthStates>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 40),
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
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.camera_alt)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "User Name : omar yasser",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email : example@gmail.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phone Number:01284544220 ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 120),
                Row(
                  children: [
                    SizedBox(
                      width: 650,
                    ),
                    Text(
                      "Logout",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 30,
                        )),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<int, int> productCounters = {};

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.list, size: 40)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 40))
        ],
        title: Text(
          "Home",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                var product = state.products[index];
                int counter = productCounters[product.id] ?? 0;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "\$${product.price}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Decrease Button
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (counter >= 1) {
                                                productCounters[product.id] =
                                                    counter - 1;
                                              }
                                            });
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                        Text("$counter",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),

                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              productCounters[product.id] =
                                                  counter + 1;
                                            });
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),

                                    // Display Total Price
                                    Text(
                                      "\$${(product.price * counter).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("No products available."));
          }
        },
      ),
    );
  }
}
