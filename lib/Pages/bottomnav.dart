import 'package:event_booking/Pages/booking.dart';
import 'package:event_booking/Pages/home.dart';
import 'package:event_booking/Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNav extends StatefulWidget {
  final String userId;
  const BottomNav({super.key, required this.userId});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home home;
  late Booking booking;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    home = const Home();
    booking = const Booking();
    profile = Profile(userId: widget.userId);
    pages = [home, booking, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.book,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
