import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    userInfoMap['eventId'] = id;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future addEvent(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('Event')
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAllEvents() async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance.collection("Event").snapshots();
  }

  Future addAdminTickets(Map<String, dynamic> ticketInfo) async {
    try {
      String ticketId =
          FirebaseFirestore.instance.collection('tickets').doc().id;
      ticketInfo['ticketId'] = ticketId;
      ticketInfo['createdAt'] = DateTime.now().toIso8601String();
      ticketInfo['status'] = 'active';

      await FirebaseFirestore.instance
          .collection('tickets')
          .doc(ticketId)
          .set(ticketInfo);

      // Update event ticket count if needed
      if (ticketInfo['eventId'] != null) {
        await FirebaseFirestore.instance
            .collection('Event')
            .doc(ticketInfo['eventId'])
            .update({
          'soldTickets':
              FieldValue.increment(ticketInfo['numberOfTickets'] ?? 0),
          'lastUpdated': DateTime.now().toIso8601String(),
        });
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error adding admin tickets: $e");
      }
      return false;
    }
  }

  Future saveBookingDetails(
      Map<String, dynamic> bookingDetails, String userId) async {
    try {
      String bookingId =
          FirebaseFirestore.instance.collection('bookings').doc().id;

      bookingDetails['userId'] = userId;
      bookingDetails['bookingId'] = bookingId;
      bookingDetails['createdAt'] = DateTime.now().toIso8601String();
      bookingDetails['status'] = 'confirmed';

      // Save to main bookings collection
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .set(bookingDetails);

      // Save to user's bookings subcollection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('myBookings')
          .doc(bookingId)
          .set(bookingDetails);

      // Create admin ticket record
      Map<String, dynamic> ticketInfo = {
        'bookingId': bookingId,
        'userId': userId,
        'userName': bookingDetails['userName'],
        'userEmail': bookingDetails['userEmail'],
        'eventName': bookingDetails['eventName'],
        'eventId': bookingDetails['eventId'],
        'numberOfTickets': bookingDetails['numberOfTickets'],
        'totalAmount': bookingDetails['totalAmount'],
        'date': bookingDetails['date'],
        'location': bookingDetails['location'],
        'paymentStatus': bookingDetails['paymentStatus'],
      };

      await addAdminTickets(ticketInfo);

      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error saving booking: $e");
      }
      return false;
    }
  }

  Future<Stream<QuerySnapshot>> getUserBookings(String userId) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('myBookings')
        .orderBy('bookingTime', descending: true)
        .snapshots();
  }

  // New method to get all tickets for admin
  Future<Stream<QuerySnapshot>> getAllTickets() async {
    return FirebaseFirestore.instance
        .collection('tickets')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateExistingEventsWithId() async {
  try {
    QuerySnapshot events = await FirebaseFirestore.instance.collection("Event").get();
    
    for (var doc in events.docs) {
      if (doc.data() is Map<String, dynamic> && 
          !(doc.data() as Map<String, dynamic>).containsKey('eventId')) {
        await FirebaseFirestore.instance
            .collection("Event")
            .doc(doc.id)
            .update({'eventId': doc.id});
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error updating events with IDs: $e");
    }
  }
}
}
