import 'package:flutter/material.dart';
import 'package:native_app/providers/great_places.dart';
import 'package:native_app/screens/add_place_screen.dart';
import 'package:native_app/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlace(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Place',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
