import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter_app/model/menu_model.dart';
import 'dart:math' as math;

import 'package:test_flutter_app/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<MenuModel> menuModel = [
    const MenuModel(
        menuImage: "assets/dishTwo.png",
        menuTitle: "Trio Fajitas",
        menuPrice: "49,90 DT"),
    const MenuModel(
        menuImage: "assets/dishThree.png",
        menuTitle: "Trio Fajitas",
        menuPrice: "49,90 DT"),
    const MenuModel(
        menuImage: "assets/dishFour.png",
        menuTitle: "Trio Fajitas",
        menuPrice: "49,90 DT"),
    const MenuModel(
        menuImage: "assets/dishFive.png",
        menuTitle: "Trio Fajitas",
        menuPrice: "49,90 DT"),
    const MenuModel(
        menuImage: "assets/dishSix.png",
        menuTitle: "Trio Fajitas",
        menuPrice: "49,90 DT"),
    const MenuModel(
        menuImage: "assets/dishSeven.png",
        menuTitle: "Trio Fajitas",
        menuPrice: "49,90 DT"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pageOne(),
            SizedBox(
              height: 300.h.w,
            ),
            headerPageTwo(),
            SizedBox(
              height: 150.h.w,
            ),
            menuList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Voir plus",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 32.sp,
                        color: const Color(0xffDE3C3C)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150.h.w,
            ),
            menuList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Voir plus",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 32.sp,
                        color: const Color(0xffDE3C3C)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150.h.w,
            ),
            contactForm(),
            SizedBox(
              height: 150.h.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget pageOne() => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/headerImage.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100.h.w,
                    ),
                    Image.asset(
                      "assets/pepper.png",
                      height: 150.h.w,
                      width: 150.h.w,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100.w,
                    ),
                    Container(
                      height: 1000.h.w,
                      width: 1000.h.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                            strokeAlign: BorderSide.strokeAlignOutside,
                            width: 6,
                            color: const Color(0xffC11F1F)),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage("assets/dishOne.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      width: 200.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chili's Tunisie",
                          style:
                              TextStyle(fontSize: 36.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          "Découvrez les\nmeilleures recettes\nsyriennes ",
                          style: GoogleFonts.getFont('Alkatra',
                              height: 1,
                              fontSize: 72.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff6EE22A)),
                        ),
                        SizedBox(
                          height: 80.h.w,
                        ),
                        SizedBox(
                          height: 80,
                          child: Row(
                            children: [
                              Container(
                                height: 120.h.w,
                                width: 350.w,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Color(0xffDB2222)),
                                      foregroundColor:
                                          const MaterialStatePropertyAll(
                                              Color(0xffffffff)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.h.w),
                                      ))),
                                  child: Text(
                                    "Voir notre menu",
                                    style: TextStyle(fontSize: 32.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget headerPageTwo() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.pepperHot,
                  size: 60.h.w, color: const Color(0xffDB2222)),
              const SizedBox(
                width: 40,
              ),
              Text(
                "Notre Menu",
                style: GoogleFonts.getFont('Alkatra',
                    height: 1,
                    fontSize: 72.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffDB2222)),
              ),
              const SizedBox(
                width: 40,
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Icon(FontAwesomeIcons.pepperHot,
                    size: 60.h.w, color: const Color(0xffDB2222)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const Divider(
                color: Color(0xffDB2222),
                thickness: 2,
              ),
            ),
          ),
        ],
      );

  Widget menuList() => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nos Fajitas",
              style: GoogleFonts.getFont(
                'Alkatra',
                height: 1,
                fontSize: 60.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff4AA80E),
              ),
            ),
            SizedBox(
              height: 80.h.w,
            ),
            Wrap(
              // crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 60.h.w, // Spacing between items
              runSpacing: 8.0, // Spacing between lines
              children: List.generate(
                menuModel.length,
                (index) => menuItem(menuModel[index]),
              ),
            ),
          ],
        ),
      );
  Widget menuItem(MenuModel menuModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400.h.w,
            width: 700.h.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: AssetImage(menuModel.menuImage), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 40.h.w,
          ),
          Text(
            menuModel.menuTitle,
            style: GoogleFonts.getFont('Alkatra',
                height: 1,
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xffDB2222)),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 20.h.w,
          ),
          Text(
            menuModel.menuPrice,
            style: GoogleFonts.getFont(
              'Alkatra',
              height: 1,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff4AA80E),
            ),
          ),
          SizedBox(
            height: 60.h.w,
          ),
        ],
      );

  Widget contactForm() => Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: 1100.h.w,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xffB61A1A)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.h.w,
                    ),
                    Text(
                      "Prendre Contact",
                      style: GoogleFonts.getFont('Alkatra',
                          height: 1,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 500.h.w,
                      width: 500.h.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/chilis.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      width: 300.h.w,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.h.w,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 100.h.w,
                        ),
                        SizedBox(
                          width: 800.h.w,
                          height: 150.h.w,
                          child: TextField(
                            cursorColor: Colors.red,
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                            decoration: InputDecoration(
                                hintText: "Nom et Prenom",
                                hintStyle: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.h.w)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.circular(30.h.w)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          width: 800.h.w,
                          height: 150.h.w,
                          child: TextField(
                            cursorColor: Colors.red,
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                            decoration: InputDecoration(
                                hintText: "Adresse Email",
                                hintStyle: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.h.w)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.circular(30.h.w)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          width: 800.h.w,
                          height: 300.h.w,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 30.sp,
                            ),
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                                hintText: "Votre message ici...",
                                hintStyle: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w400),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.h.w)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.circular(30.h.w)),
                                fillColor: Colors.white,
                                filled: true),
                            maxLines: 10,
                          ),
                        ),
                        SizedBox(
                          height: 40.h.w,
                        ),
                        SizedBox(
                            width: 800.h.w,
                            height: 120.h.w,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Color(0xffffffff)),
                                    foregroundColor:
                                        const MaterialStatePropertyAll(
                                            Color(0xff000000)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0.h.w),
                                    ))),
                                onPressed: () {},
                                child: Text(
                                  "Envoyer",
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w400),
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
