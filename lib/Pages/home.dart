import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40.0, left: 10.0,right: 10.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffe3f2fd), Color(0xffbbdefb), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on_outlined,color: Colors.blue,size: 20,),
                    Text(
                      "Pune, Maharashtra",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Hello, Anshul",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: const Text(
                  "There are 8 events happening \naround your location",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 50.0,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 2)),
                  ]
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border:InputBorder.none,
                          // suffixIcon: Icon(Icons.search_outlined),                          
                          hintText: "Search for your location",
                          hintStyle: TextStyle(color: Colors.black38,fontSize: 16),
                        ),
                      ),
                    ),
                    Icon(Icons.search_outlined,
                    color: Colors.blue,
                    size: 24,)
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 170, // Increased height to prevent bottom cut-off
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0), // Added padding to ListView
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Example of one card - repeat this structure for others
                    Container(
                      margin: const EdgeInsets.only(
                          right: 10.0), // Increased margin between cards
                      width: 160, // Slightly increased width
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                "Images/party.jpg",
                                height: 120, // Adjusted height
                                width: double
                                    .infinity, // Make image take full width
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Full width for text container
                              padding: const EdgeInsets.all(
                                  12.0), // Increased padding
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "PARTY",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 10.0), // Increased margin between cards
                      width: 160, // Slightly increased width
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                "Images/party.jpg",
                                height: 120, // Adjusted height
                                width: double
                                    .infinity, // Make image take full width
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Full width for text container
                              padding: const EdgeInsets.all(
                                  12.0), // Increased padding
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "PARTY",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 10.0), // Increased margin between cards
                      width: 160, // Slightly increased width
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                "Images/party.jpg",
                                height: 120, // Adjusted height
                                width: double
                                    .infinity, // Make image take full width
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Full width for text container
                              padding: const EdgeInsets.all(
                                  12.0), // Increased padding
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "PARTY",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 10.0), // Increased margin between cards
                      width: 160, // Slightly increased width
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                "Images/party.jpg",
                                height: 120, // Adjusted height
                                width: double
                                    .infinity, // Make image take full width
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Full width for text container
                              padding: const EdgeInsets.all(
                                  12.0), // Increased padding
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "PARTY",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 10.0), // Increased margin between cards
                      width: 160, // Slightly increased width
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                "Images/party.jpg",
                                height: 120, // Adjusted height
                                width: double
                                    .infinity, // Make image take full width
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double
                                  .infinity, // Full width for text container
                              padding: const EdgeInsets.all(
                                  12.0), // Increased padding
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  // topLeft: Radius.circular(10),
                                  // topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "PARTY",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),                      
                    ),                    
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
const Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      "Upcoming Events",
      style: TextStyle(
        color: Colors.black87,
        fontSize: 20.0,
        fontWeight: FontWeight.w600
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Text(
        "See all",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 20.0
        ),
      ),
    )
  ],
),
const SizedBox(height: 20.0),
Container(
  // margin: const EdgeInsets.only(right: 10.0),
  width: MediaQuery.of(context).size.width,
  height: 200, // Added fixed height
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 2,
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset(
              "Images/party.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "New Year's Eve",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "31 Dec, 2024",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Club House",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
  
  ),
          )
            ],
        ),
      ),
      ),
    );
  }
}
