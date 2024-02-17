import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/domain/repository/home_repository.dart';
import 'package:flutter_application_1/src/modules/home/home_module.dart';
import 'package:flutter_application_1/src/shared/helpers/extensions/mask_factory.dart';
import 'package:get_it/get_it.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends HomeModule<MyHomePage> {
  late final HomeRepository homeRepository;
  final cpfMask = TextEditingController().cpf();
  final cellphonMask = TextEditingController().cellphone();
  final moneyMask = TextEditingController().money();
  @override
  void initState() {
    super.initState();
    homeRepository = GetIt.I.get<HomeRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'teste',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              controller: cpfMask,
            ),
            TextField(
              controller: cellphonMask,
            ),
            TextField(
              controller: moneyMask,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(cpfMask.unmaskedValue());
          print(cellphonMask.unmaskedValue());
          print(moneyMask.unmaskedToCurrency());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
