import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ABSI Calculator',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _sex = 1;
  // the controller for the text field associated with "age"
  final _ageController = TextEditingController();

  // the controller for the text field associated with "height"
  final _heightController = TextEditingController();

  // the controller for the text field associated with "weight"
  final _weightController = TextEditingController();

  // the controller for the text field assosiated with "waist"
  final _waistController = TextEditingController();

  double _absi;

  void _calculate() {
    final double height = double.tryParse(_heightController.value.text);
    final double weight = double.tryParse(_weightController.value.text);
    final double waist = double.tryParse(_waistController.value.text);

    setState(() {
      double heightm = height / 100;
      double waistm = waist / 39.37;
      double bmi = weight / (heightm * heightm);
      double bmis = pow(bmi, 2 / 3);
      double heights = pow(heightm, 1 / 2);
      _absi = waistm / (bmis * heights);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ABSI CALCULATOR"),
          backgroundColor: Colors.indigo[900],
        ),
        backgroundColor: Colors.blue,
        body: Center(
          child: Container(
            width: 320,
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton(
                        value: _sex,
                        items: [
                          DropdownMenuItem(
                            child: Text("Male"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: 2,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _sex = value;
                          });
                        }),
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Age (years old)'),
                      controller: _ageController,
                    ),
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Height (cm)'),
                      controller: _heightController,
                    ),
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Weight (kg)'),
                      controller: _weightController,
                    ),
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          labelText: 'Waist Circumference (inches)'),
                      controller: _waistController,
                    ),
                    ElevatedButton(
                      onPressed: _calculate,
                      child: Text('Calculate'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        _absi == null
                            ? 'ABSI Result'
                            : _absi.toStringAsFixed(4),
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
