import 'package:flutter/material.dart';
import 'package:tourist_app/Allscreens/mainscreen.dart';
import 'package:tourist_app/DataHandler/appData.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tourist_app/models/place.dart';
import 'package:tourist_app/screens/search.dart';
import 'package:tourist_app/services/geolocator_service.dart';
import 'package:tourist_app/services/places_service.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/locate': (context) => MyApp2(),
      },
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MainScreen.idScreen,
        routes: {
          MainScreen.idScreen: (context) => MainScreen(),
          //SearchScreen.idScreen: (context) => SearchScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
class MyApp2 extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Emergency Services',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Emergency Services'),
            backgroundColor: Colors.green,
          ),
          body: Search(),
        ),
      ),
    );
  }
}

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() {
    return _DropdownExampleState();
  }
}

class _DropdownExampleState extends State<DropdownExample> {
  String _value = 'one';
  var details = {
    'one': 'atm',
    'two': 'bank',
    'three': 'bus_station',
    'four': 'car_repair',
    'five': 'gas_station',
    'six': 'gas_station',
    'seven': 'hospital',
    'eight': 'pharmacy',
    'nine': 'police',
    'ten': 'post_office',
  };
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            child: Text('ATM'),
            value: 'one',
          ),
          DropdownMenuItem<String>(
            child: Text('Bank'),
            value: 'two',
          ),
          DropdownMenuItem<String>(
            child: Text('Bus Station'),
            value: 'three',
          ),
          DropdownMenuItem<String>(
            child: Text('Car repair'),
            value: 'four',
          ),
          DropdownMenuItem<String>(
            child: Text('Gas Station'),
            value: 'five',
          ),
          DropdownMenuItem<String>(
            child: Text('Gas Station'),
            value: 'six',
          ),
          DropdownMenuItem<String>(
            child: Text('Hospital'),
            value: 'seven',
          ),
          DropdownMenuItem<String>(
            child: Text('Pharmacy'),
            value: 'eight',
          ),
          DropdownMenuItem<String>(
            child: Text('Police Station'),
            value: 'nine',
          ),
          DropdownMenuItem<String>(
            child: Text('Post Office'),
            value: 'ten',
          ),
        ],
        onChanged: (String value) {
          setState(() {
            _value = value;
            PlacesService.place = details[value];
          });
        },
        hint: Text('Airport'),
        value: _value,
      ),
    );
  }
}

