import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> coffeeTypes = [
  "Cappuccino",
  "Espresso",
  "Latte",
  "Flat White",
  "Bubble tea"
];

class CoffeeList extends StatefulWidget {
  const CoffeeList({super.key});

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [Colors.white, Colors.black.withOpacity(0.05)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [.8, 1],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: coffeeTypes.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCoffeeCategory(index);
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildCoffeeCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              coffeeTypes[index],
              style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: index == selected
                      ? const Color.fromRGBO(209, 120, 66, 1)
                      : const Color(0x00a7a8ac).withOpacity(1)),
            ),
          ),
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: index == selected
                  ? const Color.fromRGBO(209, 120, 66, 1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}
