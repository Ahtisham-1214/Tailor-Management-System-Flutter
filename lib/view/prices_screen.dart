import 'package:flutter/material.dart';

import '../model/prices.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _kameezShalwaarController = TextEditingController();
  final _shirtController = TextEditingController();
  String? _message;
  Color _messageColor = Colors.red;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _validatePrice() async {
    if (_formKey.currentState!.validate()) {
      String kameezShalwaar = _kameezShalwaarController.text;
      String shirt = _shirtController.text;
      try {
        if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(kameezShalwaar)) {
          setState(() {
            _message = 'Kameez Shalwaar Price must contains only numbers';
            _messageColor = Colors.red;
          });
        } else if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(shirt)) {
          setState(() {
            _message = 'Shirt Price must contains only numbers';
            _messageColor = Colors.red;
          });
        } else {
          Price price = Price(
            kameezShalwaar: double.parse(kameezShalwaar),
            shirt: double.parse(shirt),
          );
          setState(() {
            _message = 'Price Set Successfully';
            _messageColor = Colors.green;
          });
        }
      } catch (e) {
        setState(() {
          _message = 'An error occurred: $e';
          _messageColor = Colors.red;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Screen'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _message!,
                    style: TextStyle(color: _messageColor, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),

              TextFormField(
                controller: _kameezShalwaarController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kameez Shalwaar Price',
                  prefixIcon: const Icon(Icons.price_change),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Kameez Shalwaar Price';
                  } else if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value)) {
                    return 'Kameez Shalwaar Price must contains only numbers';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _shirtController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Shirt Price',
                  prefixIcon: const Icon(Icons.price_change),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Shirt Price';
                  } else if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value)) {
                    return 'Shirt Price must contains only numbers';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _validatePrice,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Set Price',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
