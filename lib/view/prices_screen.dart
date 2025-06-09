import 'package:flutter/material.dart';

import '../model/prices.dart';
import '../model/prices_repository.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _kameezShalwaarController = TextEditingController();
  final _shirtController = TextEditingController();
  final PriceRepository _priceRepository = PriceRepository();
  String? _message;
  Color _messageColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _getPrice();
  }

  @override
  void dispose() {
    super.dispose();
    _kameezShalwaarController.dispose();
    _shirtController.dispose();
  }

  Future<void> _savePrice() async {
    if (_formKey.currentState!.validate()) {
      String kameezShalwaar = _kameezShalwaarController.text;
      String shirt = _shirtController.text;
      try {
          Price price = Price(
            kameezShalwaar: double.parse(kameezShalwaar),
            shirt: double.parse(shirt),
          );
          setState(() {
            _priceRepository.setPrice(price);
            _message = 'Price Set Successfully';
            _messageColor = Colors.green;
          });
      } catch (e) {
        setState(() {
          _message = 'An error occurred: $e';
          _messageColor = Colors.red;
        });
      }
    }
  }

  Future<void> _getPrice() async {
    try {
      Price? price = await _priceRepository.getPrice();
      if (price != null) {
        setState(() {
          _kameezShalwaarController.text = price.kameezShalwaarPrice.toString();
          _shirtController.text = price.shirtPrice.toString();
        });
      }else{
        setState(() {
          _message = 'No Price Found';
          _messageColor = Colors.red;
        });
      }
    } catch (e) {
      setState(() {
        _message = 'An error occurred: $e';
        _messageColor = Colors.red;
      });
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
                    return 'Invalid Kameez Shalwaar Price';
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
                    return 'Invalid Shirt Price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _savePrice,
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
