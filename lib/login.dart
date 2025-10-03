import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;

  const LoginPage({super.key, this.onThemeToggle, this.isDarkMode = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mail = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Mock users data
  static const Map<String, String> usr = {
    '23AIML010@charusat.edu.in': '14082006_23AIML010',
    '23AIML047@charusat.edu.in': '19092005_23AIML047',
    '23AIML123@charusat.edu.in': '05122004_23AIML123',
    '23AIML456@charusat.edu.in': '03072003_23AIML456',
    '23AIML789@charusat.edu.in': '22112002_23AIML789',
    '23AIML101@charusat.edu.in': '14052001_23AIML101',
    '23AIML202@charusat.edu.in': '09102000_23AIML202',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Notice Board'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'University Notice Board App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text('Login', style: TextStyle(fontSize: 18)),

                const SizedBox(height: 16),

                TextFormField(
                  controller: mail,
                  decoration: const InputDecoration(
                    labelText: 'CHARUSAT MAIL ID',
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter MAIL' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    helperText: 'PASSWORD is your DOB_ID number',
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter password' : null,
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (usr[mail.text] == pass.text) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/dashboard',
                            arguments: {'ID': mail.text, 'pass': pass.text},
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid credentials'),
                            ),
                          );
                        }
                      }
                    },

                    child: const Text('LOGIN', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
