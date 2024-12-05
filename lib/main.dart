// import 'package:barber_app/pages/login.dart';
import 'package:barber_app/Admin/admin_login.dart';
import 'package:barber_app/Admin/booking_admin.dart';
import 'package:barber_app/pages/onboarding.dart';
// import 'package:barber_app/pages/signup.dart';
// import 'package:barber_app/pages/home.dart';
// import 'package:barber_app/pages/booking.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCzs3YvITD4okEDdlQLwUhh9liyOd9AUNs",
      appId: "1:487519308273:web:514eded128c75ad5b15c50",
      messagingSenderId: "487519308273",
      projectId: "barberapp-7f488",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nepth Barber Shop - Booking System',
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
