import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenify_new/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:greenify_new/screens/loginpage.dart';
import 'package:greenify_new/utilities/authcontroller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBbx00WCf5fou_CgiD7VYSLw52cRIRAD18",
        appId: "1:581154959428:web:c01b653d8a1332eac10c11",
        messagingSenderId: "581154959428",
        projectId: "greenifyapp-52a42",
        storageBucket: "greenifyapp-52a42.appspot.com",
      ),
    ).then((value) => Get.put(AuthController()));
  } else {
    await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const LoginPage(),
        },
      ),
    );
  }
}
