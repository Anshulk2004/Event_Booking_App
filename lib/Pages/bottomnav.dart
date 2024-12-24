import 'package:event_booking/Pages/booking.dart';
import 'package:event_booking/Pages/home.dart';
import 'package:event_booking/Pages/profile.dart';
import 'package:event_booking/admin/ticketevent.dart';
import 'package:event_booking/admin/upload_event.dart';
import 'package:event_booking/services/shared_pref.dart';
import 'package:flutter/foundation.dart';
// import ', required String userId, required String userIdpackage:flutter/foundation.dart';
// import ', required String userIdpackage:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  final String userId;
  const BottomNav({super.key, required this.userId});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  
  // late Booking booking;
  // late Profile profile;
  // late Ticketevent ticketEvent;
  // late UploadEvent uploadEvent;
  // int currentTabIndex = 0;
  // bool isAdmin = false;

  List<Widget> pages = [];  
  int currentTabIndex = 0;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    // home = const Home();
    // booking = const Booking();
    // profile = Profile(userId: widget.userId);
    // pages = [home, booking, profile];
    // ticketEvent = const Ticketevent();
    // uploadEvent = const UploadEvent();  
    initializePages();  
    checkAdminStatus();
  }

  void initializePages() {
    // Initialize pages with proper userId
    pages = [
      const Home(),
      Booking(userId: widget.userId),
      Profile(userId: widget.userId),
    ];
  }


  Future<void> checkAdminStatus() async {
    bool adminStatus = await SharedPreferenceHelper.getIsAdmin();
    
    if (mounted) {
      setState(() {
        isAdmin = adminStatus;
        pages = isAdmin 
            ? [
                const Home(),
                Booking(userId: widget.userId),
                const Ticketevent(),
                const UploadEvent(),
                Profile(userId: widget.userId),
              ]
            : [
                const Home(),
                Booking(userId: widget.userId),
                Profile(userId: widget.userId),
              ];
        
        if (currentTabIndex >= pages.length) {
          currentTabIndex = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
       print('Current admin status: $isAdmin');
    }
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          height: 65,
          elevation: 0,
          selectedIndex: currentTabIndex,
          backgroundColor: Colors.white,
          indicatorColor: Colors.blue.shade100,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          animationDuration: const Duration(milliseconds: 800),
          onDestinationSelected: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          destinations: isAdmin
              ? [
                  const NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home, color: Colors.blue),
                    label: 'Home',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.book_outlined),
                    selectedIcon: Icon(Icons.book, color: Colors.blue),
                    label: 'Bookings',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.confirmation_number_outlined),
                    selectedIcon: Icon(Icons.confirmation_number, color: Colors.blue),
                    label: 'Tickets',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.upload_outlined),
                    selectedIcon: Icon(Icons.upload, color: Colors.blue),
                    label: 'Upload',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person, color: Colors.blue),
                    label: 'Profile',
                  ),
                ]
              : [
                  const NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home, color: Colors.blue),
                    label: 'Home',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.book_outlined),
                    selectedIcon: Icon(Icons.book, color: Colors.blue),
                    label: 'Bookings',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person, color: Colors.blue),
                    label: 'Profile',
                  ),
                ],
        ),
      ),
    );
  }
}