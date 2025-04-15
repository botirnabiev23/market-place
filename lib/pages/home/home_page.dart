import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:market_place/pages/home/widgets/bottom_bar_item_widget.dart';

class HomePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.navigationShell.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    _selectedIndex = widget.navigationShell.currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(index);
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
              icon: CustomBottomNavIcon(
                icon: Icons.category_outlined,
                isSelected: _selectedIndex == BottomNavigationItem.categories.index,
                padding: const EdgeInsets.only(bottom: 6, top: 8),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: CustomBottomNavIcon(
                icon: Icons.shopping_basket_outlined,
                isSelected: _selectedIndex == BottomNavigationItem.basket.index,
                padding: const EdgeInsets.only(bottom: 6, top: 8),
              ),
              label: 'Basket',
            ),
            BottomNavigationBarItem(
              icon: CustomBottomNavIcon(
                icon: Icons.person,
                isSelected: _selectedIndex == BottomNavigationItem.profile.index,
                padding: const EdgeInsets.only(bottom: 6, top: 8),
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
