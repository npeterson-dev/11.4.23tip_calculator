import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variables to store bill amount and selected service level
  double _billAmount = 0;
  String _selectedServiceLevel = 'Normal';

  // function to update bill amount when the textfield changes
  void _updateBillAmount(String value) {
    setState(() {
      _billAmount = double.tryParse(value) ?? 0;
    });
  }

  // function to update selected service level when dropdownbutton changes
  void _updateServiceLevel(String? value) {
    if (value != null) {
      setState(() {
        _selectedServiceLevel = value;
      });
    }
  }

  // function to calculate the tip based on service level and bill amount
  double _calculateTip() {
    const double normalTipPercentage = 0.18;
    const double outstandingTipPercentage = 0.20;

    double tipPercentage = _selectedServiceLevel == 'Outstanding'
      ? outstandingTipPercentage
        : normalTipPercentage;

    return _billAmount * tipPercentage;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: _updateBillAmount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Bill Amount',
                hintText: 'Enter the bill amount',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedServiceLevel,
              onChanged: _updateServiceLevel,
              items: <String>['Normal', 'Outstanding'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                 );
            }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Tip Amount: \$${_calculateTip().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
