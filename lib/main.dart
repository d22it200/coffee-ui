import 'dart:ui';

import 'package:coffee_ui/coffeeList.dart';
import 'package:coffee_ui/coffeeTile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(12, 15, 20, 1),
        appBar: buildAppBar(),
        bottomNavigationBar: buildBottomNavigationBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'FIND THE BEST COFFEE FOR YOU',
                  style: GoogleFonts.bebasNeue(fontSize: 55, letterSpacing: 2),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildSearchBar(size),
              const SizedBox(
                height: 20,
              ),
              const CoffeeList(),
              const SizedBox(
                height: 20,
              ),
              const CoffeeTile(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Special FOR YOU',
                  style: GoogleFonts.bebasNeue(fontSize: 30, letterSpacing: 2),
                ),
              ),
              buildSpecialContainer(size),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Padding buildSpecialContainer(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 200,
        width: size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0x00262b33).withOpacity(1),
              const Color(0x000c0f14).withOpacity(1),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AspectRatio(
              aspectRatio: .9,
              child: Container(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                image: DecorationImage(
                  image: AssetImage(coffees[2].image),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              )),
            ),
            SizedBox(
                width: size.width - 2 * 20 - 162 - 3 * 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('5 coffee beans you must try !',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        letterSpacing: 2,
                      )),
                ))
          ],
        ),
      ),
    );
  }

  ClipRect buildBottomNavigationBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 30),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: const Color(0x000c0f14).withOpacity(0.7),
          iconSize: 50,
          currentIndex: index,
          unselectedIconTheme: const IconThemeData(
            color: Color.fromRGBO(34, 38, 47, 1),
            size: 35,
          ),
          selectedIconTheme: const IconThemeData(
              color: Color.fromRGBO(209, 120, 66, 1), size: 35),
          onTap: (int index) {
            setState(() {
              this.index = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_rounded,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }

  Padding buildSearchBar(Size size) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 50,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(34, 38, 47, 1),
              // border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: Color.fromRGBO(82, 85, 91, 1),
                size: 30,
              ),
              SizedBox(
                width: size.width - 2 * 45 - 30 - 20,
                child: TextField(
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    wordSpacing: 5,
                  ),
                  decoration: InputDecoration(
                      hintText: "Find Your Coffee ...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: const Color(0x0052555a).withOpacity(1),
                      )),
                ),
              )
            ],
          ),
        ));
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 30),
            child: AppBar(
              toolbarHeight: 70,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: const Color(0x000c0f14).withOpacity(0.4),
              leading: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  // padding: EdgeInsets.all(10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0x00262b33).withOpacity(1),
                        const Color(0x000c0f14).withOpacity(1),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.menu,
                    size: 30,
                    color: const Color(0x0052555a).withOpacity(1),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    // padding: EdgeInsets.all(10),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0x00262b33).withOpacity(1),
                          const Color(0x000c0f14).withOpacity(1),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: const Color(0x0052555a).withOpacity(1),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
