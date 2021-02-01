import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/screens/weight_page.dart';
import 'package:provider_tracker/state/weight_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Provider Tracker',
        theme: ThemeData(primaryColor: Color(0xFF1a202b)),
        home: WeightPage(),
        debugShowCheckedModeBanner: false,
      ),
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeightState(),
        )
      ],
    );
  }
}
