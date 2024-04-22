import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Option #1
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAzPvnxUBwji_6jqjWIg67uMBLoYqH3nwM',
        appId: '1:813720687919:web:ed479b5f11a900a0f9fdda',
        messagingSenderId: '813720687919',
        projectId: 'instagram-clone-2f5bc',
        storageBucket: "instagram-clone-2f5bc.appspot.com",
      ),
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyDhnfkY3Saw3n1s_ovxhHpT2U3EnB1JaGo',
      appId: '1:813720687919:android:3085885ddd8bf1b4f9fdda',
      messagingSenderId: '813720687919',
      projectId: 'instagram-clone-2f5bc',
      storageBucket: "instagram-clone-2f5bc.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

//Option #2
  // Platform.isAndroid
  //     ? await Firebase.initializeApp(
  //         options: const FirebaseOptions(
  //         apiKey: 'AIzaSyDhnfkY3Saw3n1s_ovxhHpT2U3EnB1JaGo',
  //         appId: '1:813720687919:android:3085885ddd8bf1b4f9fdda',
  //         messagingSenderId: '813720687919',
  //         projectId: 'instagram-clone-2f5bc',
  //         storageBucket: "instagram-clone-2f5bc.appspot.com",
  //       ))
  //     : await Firebase.initializeApp();

  //Option #3
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //   apiKey: 'AIzaSyDhnfkY3Saw3n1s_ovxhHpT2U3EnB1JaGo',
  //   appId: '1:813720687919:android:3085885ddd8bf1b4f9fdda',
  //   messagingSenderId: '813720687919',
  //   projectId: 'instagram-clone-2f5bc',
  //   storageBucket: "instagram-clone-2f5bc.appspot.com",
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //MultiProvider makes it take list of providers
    //As our app gets bigger we will have to use a lot of providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // ),

        home: StreamBuilder(
          //#3 Method: Auth State Changes
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }

//Run in web
//flutter run -d edge --web-renderer html

//Changing of screen methods
//StreamBuilder(
//#2 Method: User Changes
//The Stream will be called when the user register or log in, or when the user sign out, or when the token id changes
//   stream: FirebaseAuth.instance.idTokenChanges(),
//   builder: (context, snapshot) {},
// ),
//Explanation:
//When the user restores the app to a new device, this will run and get the authentication state back, Note: but we dont want to do that

//#2
// StreamBuilder(
//         //#2 Method: User Changes
//         //The Stream will be called when the user register or log in, or when the user sign out, or when the token id changes
//         stream: FirebaseAuth.instance.userChanges(),
//         builder: (context, snapshot) {},
//       ),
//Explanation:
//Same with ID Token Change, it just has an added functionality of when the user updates the password and email. Firebase provides some methods for those functions.
//Whenever those functions/methods(update informations) gets called,the .userChanges() function gets called as well.

//#3
// StreamBuilder(
//         //#3 Method: Auth State Changes
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {},
//       ),
//Explanation:
//This will run only when the user signs in or signs out
}
