import 'package:flutter/material.dart';
import 'package:tailor_management/model/shop_details_repository.dart';
import 'package:tailor_management/model/shop_details.dart';
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
  final ShopDetailsRepository _shopDetailsRepository = ShopDetailsRepository();

  @override
  void initState() {
    super.initState();
    _fetchShopDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _shopNameController.dispose();
    _shopAddressController.dispose();
    _shopPhoneController.dispose();
    _shopEmailController.dispose();
  }

  Future<void> _fetchShopDetails() async {
    try {
      final shopDetail = await _shopDetailsRepository.getShopDetails();
      if (shopDetail != null) {
        setState(() {
          _shopNameController.text = shopDetail.shopName;
          _shopAddressController.text = shopDetail.address;
          _shopPhoneController.text = shopDetail.phoneNumber;
          _shopEmailController.text = shopDetail.mail;
        });
        }else{
          setState(() {
            _message = 'No Shop Details Found';
            _messageColor = Colors.red;
          });
        }
      }
      catch(e){
      setState(() {
        _message = 'Error fetching shop details: $e';
        _messageColor = Colors.red;
      });
      }
  }
  Future<void> _saveShopDetails() async {
    if (_formKey.currentState!.validate()) {
      String shopName = _shopNameController.text;
      String shopAddress = _shopAddressController.text;
      String shopPhone = _shopPhoneController.text;
      String shopEmail = _shopEmailController.text;

      try{
        final shopDetail = ShopDetail(
          shopName: shopName,
          address: shopAddress,
          phoneNumber: shopPhone,
          mail: shopEmail,
        );
        _shopDetailsRepository.setShopDetails(shopDetail);

        setState(() {
          _message = 'Shop Details Set Successfully';
          _messageColor = Colors.green;
        });

      }catch(e){
        setState(() {
          _message = 'Error saving shop details: $e';
          _messageColor = Colors.red;
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
                onPressed: _saveShopDetails,
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
