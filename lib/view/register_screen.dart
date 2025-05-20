import 'package:flutter/material.dart';
import '../model/user_repository.dart';
import '../model/user.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserRepository _userRepository = UserRepository();
  String? _message;
  Color _messageColor = Colors.red;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      try {
        final existingUser = await _userRepository.getUserByUsername(username);
        if (existingUser != null) {
          setState(() {
            _message = 'Username already exists.';
            _messageColor = Colors.red;
          });
        } else {
          await _userRepository.insertUser(User(userName: username, password: password));
          setState(() {
            _message = 'Registration successful! Please login.';
            _messageColor = Colors.green;
          });
          // Optionally navigate back to login:
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return;
            Navigator.pop(context);
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
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_message != null)
                Text(_message!, style: TextStyle(color: _messageColor)),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'Password must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
