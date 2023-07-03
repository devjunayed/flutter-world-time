// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic data;
  String location = '';
  String time = '';
  String flag = '';
  late bool isDay;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    if (data != null && data is Map<String, dynamic> && location.isEmpty) {
      location = data['location'] as String;
      time = data['time'] as String;
      flag = data['flag'] as String;
      isDay = data['isDayTime'] as bool;
    }

    String bgImage = isDay ? 'assets/day.png' : 'assets/night.png';
    Color? bgColor = isDay ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      time = result['time'];
                      location = result['location'];
                      isDay = result['isDayTime'];
                      flag = result['flag'];
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$location',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.grey[300],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.grey[300],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
