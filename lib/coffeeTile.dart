import 'package:coffee_ui/details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Coffee {
  final int id;
  final String name, madeWith, description, roasted, image, price, rating;
  bool fav;
  Coffee(this.id, this.name, this.madeWith, this.description, this.roasted,
      this.image, this.rating, this.price, this.fav);
}

List<Coffee> coffees = [
  Coffee(
      1,
      "CAPPUCCINO",
      "WITH OAT MILK",
      "Aromatic espresso meets velvety milk in our exquisite cappuccino. This vibrant coffee waltz dances on your palate, crowned with a touch of cocoa",
      "MEDIUM",
      "assets/alisa-anton-FbRGK2rZs8g-unsplash.jpg",
      "4.5",
      "4.50",
      false),
  Coffee(
      2,
      "CAPPUCCINO",
      "WITH CHOCOLATE",
      "Aromatic espresso meets velvety milk in our exquisite cappuccino. This vibrant coffee waltz dances on your palate, crowned with a touch of cocoa",
      "MEDIUM",
      "assets/anubhav-arora-RFLDagtOsMM-unsplash.jpg",
      "4.9",
      "3.00",
      false),
  Coffee(
      3,
      "CAPPUCCINO",
      "WITH MILK",
      "Aromatic espresso meets velvety milk in our exquisite cappuccino. This vibrant coffee waltz dances on your palate, crowned with a touch of cocoa",
      "MEDIUM",
      "assets/max-ducourneau-GSonp8kaKQ8-unsplash.jpg",
      "4.7",
      "3.40",
      false),
];

class CoffeeTile extends StatefulWidget {
  const CoffeeTile({super.key});

  @override
  State<CoffeeTile> createState() => _CoffeeTileState();
}

class _CoffeeTileState extends State<CoffeeTile> {
  final PageController _pageController = PageController(
    viewportFraction: 1 / 3,
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: ListView.builder(
            // physics: const ClampingScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildCoffeeTile(index);
            },
            itemCount: coffees.length,
          ),
        ));
  }

  InkWell buildCoffeeTile(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(coffee: coffees[index])));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              width: 177,
              margin: const EdgeInsets.symmetric(horizontal: 10),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          // height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            image: DecorationImage(
                              image: AssetImage(coffees[index].image),
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20),
                    child: Text(
                      coffees[index].name,
                      style:
                          GoogleFonts.bebasNeue(fontSize: 20, letterSpacing: 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      coffees[index].madeWith,
                      style: GoogleFonts.bebasNeue(
                          letterSpacing: 2,
                          fontSize: 10,
                          color: const Color(0x00a7a7a8).withOpacity(1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money,
                              color: Color.fromRGBO(209, 120, 66, 1),
                              size: 21,
                            ),
                            Text(
                              coffees[index].price,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 23, letterSpacing: 2),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(209, 120, 66, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
