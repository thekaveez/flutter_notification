import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/api/firebase_api.dart';
import 'package:flutter_notification/api/payload_service.dart';
import 'package:flutter_notification/firebase_options.dart';
import 'package:flutter_notification/pages/notification_page.dart';
import 'api/local_notification_service.dart';
import 'pages/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotificationService.initialize();
  tz.initializeTimeZones();
  await FirebaseApi().initNotifications();
  await PayloadService().savePayload(payload: ['Nimal', 'Kamal', 'Sunil', 'Amal', 'Kasun']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => const HomePage(),
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}


