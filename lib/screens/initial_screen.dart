import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'ELC Activity Shop Project',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
        ),
        body: Column(children: [
          Image.asset('assets/images/dev.png'),
          Image.asset('assets/images/learn.png'),
          ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/login');
                context.vxNav.push(Uri.parse('/login'));
              },
              child: const Text('Login')),
        ]));
  }
}
