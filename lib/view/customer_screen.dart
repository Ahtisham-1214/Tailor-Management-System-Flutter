import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  CustomerScreenState createState() => CustomerScreenState();
}

class CustomerScreenState extends State<CustomerScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  final _customerNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _shoulderController = TextEditingController();
  final _neckController = TextEditingController();
  final _chestController = TextEditingController();
  final _sleevesLengthController = TextEditingController();
  final _kameezLengthController = TextEditingController();

  String? _message;
  Color _messageColor = Colors.red;

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalSteps = 3; // Define total steps

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _phoneNumberController.dispose();
    _shoulderController.dispose();
    _neckController.dispose();
    _chestController.dispose();
    _sleevesLengthController.dispose();
    _kameezLengthController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void _previousPage() {
    // Added back for manual backward swipe
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _validateStep(int step) async {
    bool isValid = false;

    switch (step) {
      case 0:
        isValid = _formKey1.currentState!.validate();
        break;
      case 1:
        isValid = _formKey2.currentState!.validate();
        break;
      case 2:
        isValid = _formKey3.currentState!.validate();
        break;
    }

    if (isValid) {
      setState(() {
        _message = null;
      });

      if (step < _totalSteps - 1) {
        _nextPage();
      } else {
        setState(() {
          _message = 'All customer details added successfully! 🎉';
          _messageColor = Colors.green;
        });
        print('Customer Data Submitted:');
        print('Name: ${_customerNameController.text}');
        print('Phone: ${_phoneNumberController.text}');
        print('Shoulder: ${_shoulderController.text}');
      }
    } else {
      setState(() {
        _message = 'Please correct the errors in the current step. ⚠️';
        _messageColor = Colors.red;
      });
    }
  }

  Widget _buildProgressIndicator() {
    final double availableWidth = MediaQuery.of(context).size.width - 32.0;
    final double segmentLength = availableWidth / (_totalSteps - 1);
    final double activeLineWidth = _currentPage * segmentLength;

    return Container(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 18,
            right: 18,
            child: Container(height: 2.0, color: Colors.grey),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            left: 18,
            width: activeLineWidth,
            child: Container(height: 2.0, color: Colors.blue),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_totalSteps, (index) {
              bool isActiveOrCompleted = _currentPage >= index;
              return GestureDetector(
                onTap: () {
                  if (index <= _currentPage) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isActiveOrCompleted ? Colors.blue : Colors.grey[400],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isActiveOrCompleted ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Customer Screen'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildProgressIndicator(),
            const SizedBox(height: 20.0),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _message!,
                  style: TextStyle(color: _messageColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            Expanded(
              child: GestureDetector(
                // Use GestureDetector for custom swipe detection
                onHorizontalDragEnd: (details) {
                  // Swiping right (details.primaryVelocity > 0) means going backward
                  if (details.primaryVelocity! > 0) {
                    _previousPage();
                  }
                  // Swiping left (details.primaryVelocity < 0) is going forward, which we disallow
                  // No action taken for forward swipe here.
                },
                child: PageView(
                  controller: _pageController,
                  // IMPORTANT: Set physics to NeverScrollableScrollPhysics
                  // This completely disables ALL manual swiping (forward and backward)
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // --- Step 1: Customer Name ---
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _customerNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Customer Name',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  final String? trimmedValue =
                                      value?.trim(); // Trimming happens first

                                  if (trimmedValue == null ||
                                      trimmedValue.isEmpty) {
                                    return 'Enter Customer Name';
                                  } else if (!RegExp(
                                    r"^[A-Za-z]+([ ]?[A-Za-z]+)*$",
                                  ).hasMatch(trimmedValue)) {
                                    // Original regex is fine here because input is already trimmed
                                    return 'Customer Name must contain only alphabets and single spaces between words';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30.0),
                              TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Customer Phone Number';
                                  } else if (!RegExp(
                                    r"^\d{11}$",
                                  ).hasMatch(value)) {
                                    return 'Customer Number must contain only 11 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30.0),
                              ElevatedButton(
                                onPressed: () => _validateStep(0),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // --- Step 2: Phone Number ---
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _shoulderController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: InputDecoration(
                                        labelText: 'Shoulder',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Shoulder size';
                                        } else if (double.tryParse(value) ==
                                                null ||
                                            double.parse(value) < 1) {
                                          return 'Invalid size';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _neckController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: InputDecoration(
                                        labelText: 'Neck',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Neck size';
                                        } else if (double.tryParse(value) ==
                                                null ||
                                            double.parse(value) < 1) {
                                          return 'Invalid size';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _chestController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: InputDecoration(
                                        labelText: 'Chest',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Chest size';
                                        } else if (double.tryParse(value) ==
                                                null ||
                                            double.parse(value) < 1) {
                                          return 'Invalid size';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _sleevesLengthController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: InputDecoration(
                                        labelText: 'Sleeves Length',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Sleeves Length';
                                        } else if (double.tryParse(value) ==
                                                null ||
                                            double.parse(value) < 1) {
                                          return 'Invalid size';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _kameezLengthController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: InputDecoration(
                                        labelText: 'Kameez Length',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Kameez Length';
                                        } else if (double.tryParse(value) ==
                                                null ||
                                            double.parse(value) < 1) {
                                          return 'Invalid size';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  const Expanded(
                                    child:
                                        SizedBox(), // Empty slot to keep layout balanced (optional)
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              ElevatedButton(
                                onPressed: () => _validateStep(1),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _shoulderController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Customer Address',
                              prefixIcon: const Icon(Icons.home),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Customer Address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          ElevatedButton(
                            onPressed: () => _validateStep(2),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Confirm Order',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
