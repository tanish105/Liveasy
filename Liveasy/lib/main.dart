import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:liveasy/home.dart';
import 'enter_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      // home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.image,
              size: 40,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Please select your language',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'You can change the language at anytime.',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: LanguagePickerDropdown(
                initialValue: Languages.english,
                onValuePicked: (Language language) {
                  print(language.name);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnterMobile(),
                  ),
                );
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
