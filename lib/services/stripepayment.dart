import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:event_booking/services/database.dart';
import 'package:event_booking/services/data.dart';
import 'package:event_booking/services/shared_pref.dart';

class StripePaymentService {
  static Future<void> makePayment({
    required String amount,
    required String eventName,
    required String eventId, // Add eventId parameter
    required String location,
    required String date,
    required int numberOfTickets,
    required double ticketPrice,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final amountInSmallestUnit =
          (double.parse(amount) * 100).round().toString();

      String userName = await SharedPreferenceHelper.getUserName() ?? "";
      String userEmail = await SharedPreferenceHelper.getUserEmail() ?? "";
      String userImage = await SharedPreferenceHelper.getUserImage() ?? "";

      Map<String, dynamic>? paymentIntent = await createPaymentIntent(
          amountInSmallestUnit, 'INR' // Change to INR since you're using Rupees
          );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          merchantDisplayName: 'Event Booking',
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'IN',
            currencyCode: 'INR',
            testEnv: true,
          ),
          customFlow: false,
          style: ThemeMode.dark,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFF9c27b0),
            ),
            shapes: PaymentSheetShape(
              borderWidth: 4,
              shadow: PaymentSheetShadowParams(color: Color(0x11000000)),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color(0xFF9c27b0),
                  text: Colors.white,
                  border: Color(0xFF9c27b0),
                ),
              ),
            ),
          ),
        ),
      );

      await displayPaymentSheet(
        amount: amount,
        eventName: eventName,
        eventId: eventId,
        location: location,
        date: date,
        numberOfTickets: numberOfTickets,
        ticketPrice: ticketPrice,
        userName: userName,
        userEmail: userEmail,
        userImage: userImage,
        onSuccess: onSuccess,
        onError: onError,
      );
    } catch (e) {
      if (kDebugMode) {
        print('makePayment error: $e');
      }
      onError('Payment failed. Please try again.');
    }
  }

  static Future<void> displayPaymentSheet({
    required String amount,
    required String eventName,
    required String eventId,
    required String location,
    required String date,
    required int numberOfTickets,
    required double ticketPrice,
    required String userName,
    required String userEmail,
    required String userImage,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) async {
        String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

        Map<String, dynamic> bookingDetails = {
          "userName": userName,
          "userEmail": userEmail,
          "userImage": userImage,
          "eventId": eventId,
          "numberOfTickets": numberOfTickets,
          "totalAmount": (ticketPrice * numberOfTickets).toStringAsFixed(2),
          "eventName": eventName,
          "location": location,
          "date": date,
          "bookingTime": DateTime.now().toIso8601String(),
          "paymentStatus": "Completed",
        };

        // Save booking details to Firebase
        bool bookingSaved =
            await DatabaseMethods().saveBookingDetails(bookingDetails, userId);

        if (bookingSaved) {
          onSuccess();
        } else {
          onError('Booking failed to save');
        }
      });
    } on StripeException {
      onError('Payment cancelled');
    } catch (e) {
      onError('Payment failed');
    }
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      // final amountInCents = (double.parse(amount) * 100).round();
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
        // Add these for better error handling
        'description': 'Event Booking Payment',
        'capture_method': 'automatic',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('Payment Intent Error: ${response.body}');
          print('Status Code: ${response.statusCode}');
        }
        throw Exception('Failed to create payment intent: ${response.body}');
      }

      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('createPaymentIntent error: ${err.toString()}');
      }
      rethrow;
    }
  }
}
