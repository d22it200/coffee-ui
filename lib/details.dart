import 'dart:ui';

import 'package:coffee_ui/coffeeTile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

List<String> sizes = ["S", "M", "L"];

class Details extends StatefulWidget {
  const Details({super.key, required this.coffee});
  final Coffee coffee;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var appBarBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0x00262b33).withOpacity(1),
          const Color(0x000c0f14).withOpacity(1),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 15, 20, 1),
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(appBarBoxDecoration, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBackdropAndCard(size, widget.coffee),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Description",
                style: GoogleFonts.bebasNeue(
                    fontSize: 25,
                    letterSpacing: 1.5,
                    color: const Color(0x0052555a).withOpacity(1)),
              ),
            ),
            buildDescription(widget.coffee),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "size",
                style: GoogleFonts.bebasNeue(
                    fontSize: 25,
                    letterSpacing: 1.5,
                    color: const Color(0x0052555a).withOpacity(1)),
              ),
            ),
            buildSizes(size),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Price",
                  style: GoogleFonts.bebasNeue(),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.attach_money,
                    color: Color.fromRGBO(209, 120, 66, 1),
                    size: 21,
                  ),
                  Text(
                    widget.coffee.price,
                    style:
                        GoogleFonts.bebasNeue(fontSize: 23, letterSpacing: 2),
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(209, 120, 66, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "Buy now",
                style: GoogleFonts.bebasNeue(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding buildSizes(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return buildSizeList(index, size);
          },
          scrollDirection: Axis.horizontal,
          itemCount: sizes.length,
        ),
      ),
    );
  }

  GestureDetector buildSizeList(int index, Size size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: (size.width - 2 * 20 - 2 * 20) / 3,
          decoration: BoxDecoration(
            color: index == selected
                ? Colors.transparent
                : const Color(0x00141921).withOpacity(1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: index == selected ? 2 : 1,
                color: index == selected
                    ? const Color.fromRGBO(209, 120, 66, 1)
                    : const Color(0x0052555a).withOpacity(1)),
          ),
          child: Center(
            child: Text(
              sizes[index],
              style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                  color: index == selected
                      ? const Color.fromRGBO(209, 120, 66, 1)
                      : const Color(0x0052555a).withOpacity(1)),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildDescription(Coffee coffee) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ReadMoreText(
        coffee.description,
        style: GoogleFonts.bebasNeue(
          fontSize: 20,
        ),
        trimLines: 2,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'read more',
        trimExpandedText: ' ...read less',
        moreStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(209, 120, 66, 1)),
        lessStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(209, 120, 66, 1)),
      ),
    );
  }

  AppBar buildAppBar(BoxDecoration appBarBoxDecoration, BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: InkWell(
            child: Container(
              // padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: appBarBoxDecoration,
              child: Icon(
                Icons.chevron_left,
                color: const Color(0x0052555a).withOpacity(1),
                size: 30,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              setState(() {
                widget.coffee.fav == true
                    ? widget.coffee.fav = false
                    : widget.coffee.fav = true;
                print(widget.coffee.fav);
              });
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: appBarBoxDecoration,
              child: Icon(
                Icons.favorite,
                size: 20,
                color: widget.coffee.fav == true
                    ? const Color.fromRGBO(209, 120, 66, 1)
                    : const Color(0x0052555a).withOpacity(1),
              ),
            ),
          ),
        )
      ],
    );
  }

  Stack buildBackdropAndCard(Size size, Coffee coffee) {
    return Stack(
      children: [
        Container(
          height: size.height * .60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            image: DecorationImage(
                image: AssetImage(coffee.image),
                fit: BoxFit.cover,
                alignment: Alignment.bottomRight),
          ),
        ),
        Positioned(
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 15,
                  sigmaX: 20,
                ),
                child: Container(
                  height: 150,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.black38.withOpacity(.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coffee.name,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 30, letterSpacing: 2),
                            ),
                            Text(
                              coffee.madeWith,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color:
                                      const Color(0x00a7a7a8).withOpacity(1)),
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  size: 25,
                                  color: Color.fromRGBO(209, 120, 66, 1),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  coffee.rating,
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 30,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(12, 15, 20, 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.coffee_rounded,
                                        color: Color.fromRGBO(209, 120, 66, 1),
                                        size: 25,
                                      ),
                                      Text(
                                        "Coffee",
                                        style: GoogleFonts.bebasNeue(
                                          fontSize: 15,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(12, 15, 20, 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.water_drop_rounded,
                                        color: Color.fromRGBO(209, 120, 66, 1),
                                        size: 25,
                                      ),
                                      Text(
                                        "Milk",
                                        style: GoogleFonts.bebasNeue(
                                          fontSize: 15,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(12, 15, 20, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "${coffee.roasted} Roasted",
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: 15,
                                      letterSpacing: 1,
                                      wordSpacing: 2,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
