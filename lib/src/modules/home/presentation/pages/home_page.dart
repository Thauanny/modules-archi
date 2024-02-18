import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/domain/repository/home_repository.dart';
import 'package:flutter_application_1/src/modules/home/home_module.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firebase_service.dart';
import 'package:flutter_application_1/src/shared/helpers/extensions/mask_factory.dart';
import 'package:get_it/get_it.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends HomeModule<MyHomePage> {
  final cpfMask = TextEditingController().cpf();
  final cellphonMask = TextEditingController().cellphone();
  final moneyMask = TextEditingController().money();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mostruário de testes'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 56, vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Adicione no Firebase',
                style: Theme.of(context).textTheme.headlineSmall,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Future.wait([
            GetIt.I.get<FirebaseService>().add(
                  key: 'cpf_example',
                  value: cpfMask.unmaskedValue(),
                ),
            GetIt.I.get<FirebaseService>().add(
                  key: 'cellphone_example',
                  value: cellphonMask.unmaskedValue(),
                ),
            GetIt.I.get<FirebaseService>().add(
                  key: 'money_example',
                  value: moneyMask.unmaskedToCurrency().toString(),
                ),
          ]);

          int successful = 0;
          List<String> keys = [];

          for (var element in result) {
            if (element.uploaded) {
              successful++;
            } else {
              successful--;
              keys.add(element.key);
            }
          }

          if (successful == result.length) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Todos os dados foram adicionados com sucesso!',
                ),
                backgroundColor: Colors.green[900],
              ),
            );
          } else if (successful == 0 || successful == -result.length) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Nenhum dado foi adicionado com sucesso.',
                ),
                backgroundColor: Colors.red[900],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Alguns elementos nao foram adicionados com sucesso: ${keys.map((e) => e).toList()}.',
                ),
                backgroundColor: Colors.yellow[900],
              ),
            );
          }
        },
        tooltip: 'add',
        child: const Icon(Icons.check),
      ),
    );
  }
}
