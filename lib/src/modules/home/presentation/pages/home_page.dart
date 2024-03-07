import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mostruário de testes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/createFirebase');
                  },
                  child: const Text('Firebase'),
                ),
              )
            ],
          ),
        ));
  }
}
