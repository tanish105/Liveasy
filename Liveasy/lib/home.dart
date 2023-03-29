import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isborder = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please select your profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: isborder==1?BoxDecoration(
                  border: Border.all(color: Colors.black87),
                ):BoxDecoration(),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.circle_outlined,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          isborder=1;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.home,
                      size: 45,
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Shipper",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Lorem Ipsum",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: isborder==0?BoxDecoration(
                  border: Border.all(color: Colors.black87),
                ):BoxDecoration(),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.circle_outlined,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          isborder=0;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.fire_truck_sharp,
                      size: 45,
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Transporter",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Lorem Ipsum",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
