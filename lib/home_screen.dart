import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter_app/add_menu_screen.dart';
import 'package:test_flutter_app/globals/globals.dart';
import 'package:test_flutter_app/model/menu_model.dart';
import 'package:test_flutter_app/service/auth_service.dart';
import 'package:test_flutter_app/service/menu_service.dart';
import 'package:test_flutter_app/update_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MenuService menuService = MenuService();
  AuthService authService = AuthService();
  List<MenuModel>? menulist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(children: [
          Text(
            "Welcome "
            "${currentUser?.firstName}"
            " "
            "${currentUser?.lastName}",
            style: GoogleFonts.getFont(
              'Alkatra',
              height: 1,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Welcome " "${currentUser?.email}",
            style: GoogleFonts.getFont(
              'Alkatra',
              height: 1,
              fontSize: 16,
            ),
          ),
        ]),
        actions: [
          TextButton(
              onPressed: () {
                authService.signOut(context);
              },
              child: Text(
                "Logout",
                style: GoogleFonts.getFont('Alkatra',
                    height: 1, fontSize: 18, color: const Color(0xffDB2222)),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffDE3C3C),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddMenuScreen()),
            );
          },
          child: const Icon(
            Icons.add,
          )),
      body: StreamBuilder<List<MenuModel>>(
        stream: menuService.getAllData(),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (snapshot.data == null) {
            // Data is still loading or there was an error
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xffDE3C3C),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            // Data is loaded, but the list is empty
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Menu available',
                    style: GoogleFonts.getFont(
                      'Alkatra',
                      height: 1,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Click on the add button to create one',
                    style: GoogleFonts.getFont(
                      'Alkatra',
                      height: 1,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          } else {
            menulist = snapshot.data;
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menulist!.length,
                itemBuilder: (BuildContext context, int index) {
                  return menuItem(menulist![index]);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget menuItem(MenuModel menuModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.grey.shade200,
        leading: Image.network(
          fit: BoxFit.cover,
          menuModel.menuImage,
          height: 50,
          width: 50,
        ),
        title: Text(
          menuModel.menuTitle,
          style: GoogleFonts.getFont('Alkatra',
              height: 1,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xffDB2222)),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          menuModel.menuPrice,
          style: GoogleFonts.getFont(
            'Alkatra',
            height: 1,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff4AA80E),
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                splashRadius: 15,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateMenuScreen(
                              menuModel: menuModel,
                            )),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xff4AA80E),
                ),
              ),
              IconButton(
                  splashRadius: 15,
                  onPressed: () async {
                    await menuService.deleteMenuDocument(
                        menuModel.id!, context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xffDB2222),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
