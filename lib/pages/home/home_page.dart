import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    widget.navigationShell.goBranch(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTap,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0xffC7C7C7),
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xffC7C7C7),
          ),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 8),
                child: Image.asset(
                  'assets/images/category.png',
                  width: 24,
                  height: 24,
                  color:
                      _selectedIndex == BottomNavigationItem.categories.index
                          ? Colors.black
                          : Color(0xffC7C7C7),
                ),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 8),
                child: Icon(
                  Icons.shopping_basket_outlined,
                  color:
                      _selectedIndex == BottomNavigationItem.basket.index
                          ? Colors.black
                          : Color(0xffC7C7C7),
                ),
              ),
              label: 'Basket',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 8),
                child: SvgPicture.asset(
                  'assets/images/profile.svg',
                  color:
                      _selectedIndex == BottomNavigationItem.profile.index
                          ? Colors.black
                          : Color(0xffC7C7C7),
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

enum BottomNavigationItem { categories, basket, profile }
