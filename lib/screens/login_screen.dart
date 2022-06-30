import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var name = "";
  bool logger = false;

  final _formKey = GlobalKey<FormState>();

  handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        logger = true;
      });

      await Future.delayed(const Duration(seconds: 1));
      // Navigator.pushReplacementNamed(context, '/home');
      await context.vxNav.push(Uri.parse('/home'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Welcome $name'),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username cannot be empty";
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Enter Username", labelText: "Username"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return "Password must be atleast 6 characters";
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Enter Password", labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: logger
                                  ? BorderRadius.circular(50)
                                  : BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 36),
                        ),
                        onPressed: () => handleLogin(context),
                        // print(name);
                        child: logger
                            ? const Icon(Icons.done)
                            : const Text('Login')),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
