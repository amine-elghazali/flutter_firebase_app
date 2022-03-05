import 'package:app_firebase/models/user.dart';
import 'package:app_firebase/screens/wrapper.dart';
import 'package:app_firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,  // Listening to our user stream
      initialData: null,
      child: MaterialApp(
        home : Wrapper()
      ),
    );
  }
}

