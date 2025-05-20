import 'package:flutter/material.dart';

class ShopDetailScreen extends StatefulWidget {
  const ShopDetailScreen({super.key});

  @override
  ShopDetailScreenState createState() => ShopDetailScreenState();
}

class ShopDetailScreenState extends State<ShopDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _shopAddressController = TextEditingController();
  final _shopPhoneController = TextEditingController();
  final _shopEmailController = TextEditingController();
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

  Future<void> _validateShopDetails() async {
    if (_formKey.currentState!.validate()) {
      if (_shopNameController.text.trim().isEmpty) {
        setState(() {
          _message = 'Enter Shop Name';
          _messageColor = Colors.red;
        });
      } else if (_shopAddressController.text.trim().isEmpty) {
        setState(() {
          _message = 'Enter Shop Address';
          _messageColor = Colors.red;
        });
      } else if (_shopPhoneController.text.trim().isEmpty) {
        setState(() {
          _message = 'Enter Shop Phone Number';
          _messageColor = Colors.red;
        });
      } else if (_shopEmailController.text.trim().isEmpty) {
        setState(() {
          _message = 'Enter Shop Email';
          _messageColor = Colors.red;
        });
      } else {
        setState(() {
          _message = 'Shop Details Set Successfully';
          _messageColor = Colors.green;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Details'), centerTitle: true),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.9),
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
                controller: _shopNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.shop),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter Shop Name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30.0),

              TextFormField(
                controller: _shopAddressController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: const Icon(Icons.add_location),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter Shop Address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30.0),

              TextFormField(
                controller: _shopEmailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter Shop Email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30.0),

              TextFormField(
                controller: _shopPhoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter Shop Phone Number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30.0),

              ElevatedButton(
                onPressed: _validateShopDetails,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Set Shop Details',
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
