import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trelloapp/src/constants/constants.dart';
import 'package:trelloapp/src/providers/auth_provider.dart';
import 'package:trelloapp/src/providers/connectivity_provider.dart';
import 'package:trelloapp/src/splash_screen.dart';
import 'package:trelloapp/src/views/auth/login_screen.dart';
import 'package:trelloapp/src/views/auth/signup_screen.dart';
import 'package:trelloapp/src/views/home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (kIsWeb) {
      isWeb = true;
      print("Running on WEB");
    } else {
      isWeb = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConnectivityProvider>(
            create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: {
          '/': (context) => SplashScreen(),
          '/loginscreen': (context) => LoginScreen(),
          '/signupscreen': (context) => SignupScreen(),
          '/homescreen': (context) => HomeScreen(),
        },
      ),
    );
  }
}
