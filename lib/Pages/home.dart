import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/Pages/detail.dart';
import 'package:event_booking/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'eventcategory.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? eventStream;
  final ScrollController _scrollController = ScrollController();

  String formatDateTime(String date, String time) {
    try {
      DateTime dateTime = DateTime.parse(date);
      String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

      TimeOfDay timeOfDay = TimeOfDay(
        hour: int.parse(time.split(':')[0]),
        minute: int.parse(time.split(':')[1]),
      );
      String period = timeOfDay.hour >= 12 ? 'pm' : 'am';
      int hour = timeOfDay.hour > 12 ? timeOfDay.hour - 12 : timeOfDay.hour;
      hour = hour == 0 ? 12 : hour;

      return '$formattedDate $hour$period';
    } catch (e) {
      return '$date $time';
    }
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ontheload() async {
    eventStream = await DatabaseMethods().getAllEvents();
    setState(() {});
  }

  Widget categoryCards() {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        // physics: const BouncingScrollPhysics(),
        children: [
          EventCategoryCard(
            image: "Images/party.jpg",
            category: "PARTY",
          ),
          EventCategoryCard(
            image: "Images/party.jpg",
            category: "SPORTS",
          ),
          EventCategoryCard(
            image: "Images/party.jpg",
            category: "MUSIC",
          ),
          EventCategoryCard(
            image: "Images/party.jpg",
            category: "TECH",
          ),
          EventCategoryCard(
            image: "Images/party.jpg",
            category: "CULTURAL",
          ),
        ],
      ),
    );
  }

  Widget allEvents() {
    return StreamBuilder(
      stream: eventStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          eventName: ds['name'] ?? "Event Name",
                          date: ds['date'] ?? "",
                          time: ds['time'] ?? "",
                          location: ds['location'] ?? "Location",
                          category: ds['category'] ?? "Event",
                          details: ds['details'] ?? "",
                          price: ds['price'] ?? "0",
                          organizedBy: ds['organizedBy'] ?? "",
                          ageLimit: ds['ageLimit'] ?? "All ages",
                          image: ds['image'] ?? "Images/party.jpg",
                        ),
                      ),
                    );
                  },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
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
                                    Colors.black.withOpacity(0.8),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 15,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  ds['category'] ?? "Event",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 15,
                              right: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ds['name'] ?? "Event Name",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        formatDateTime(ds['date'], ds['time']),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        ds['location'] ?? "Location",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe3f2fd), Color(0xffbbdefb), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
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
                      Icon(Icons.location_on_outlined,
                          color: Colors.blue, size: 20),
                      SizedBox(width: 6),
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
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.0),
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
                const SizedBox(height: 15.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for your location",
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.search_outlined, color: Colors.blue, size: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                categoryCards(),
                const SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Events",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                allEvents(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
