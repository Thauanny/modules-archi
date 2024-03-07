import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/firebase_firestore_facade.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/model/firebase_response.dart';
import 'package:flutter_application_1/src/shared/helpers/extensions/mask_factory.dart';
import 'package:get_it/get_it.dart';

class FirebasePage extends StatefulWidget {
  const FirebasePage({super.key});

  @override
  State<FirebasePage> createState() => _FirebasePageState();
}

class _FirebasePageState extends State<FirebasePage> {
  final cpfMask = TextEditingController().cpf();
  final cellphonMask = TextEditingController().cellphone();
  final moneyMask = TextEditingController().money();
  late final FirebaseFireStoreFacade fire;

  @override
  void initState() {
    super.initState();
    fire = GetIt.I.get<FirebaseFireStoreFacade>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mostruário de testes - Firebase',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 56, vertical: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Adicione no Firebase',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Insira o cpf'),
                controller: cpfMask,
              ),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Insira o telefone'),
                controller: cellphonMask,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text(
                    'Valor em dinheiro',
                  ),
                ),
                controller: moneyMask,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        var result = await Future.wait([
                          fire.add(
                            key: 'cpf_example',
                            value: cpfMask.unmaskedValue(),
                          ),
                          fire.add(
                            key: 'cellphone_example',
                            value: cellphonMask.unmaskedValue(),
                          ),
                          fire.add(
                            key: 'money_example',
                            value: moneyMask.unmaskedToCurrency().toString(),
                          ),
                        ]);

                        int successful = 0;
                        List keys = [];

                        for (var element in result) {
                          if (element.uploaded) {
                            successful++;
                          } else {
                            successful--;
                            keys.add(element.data);
                          }
                        }

                        if (successful == result.length) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Todos os dados foram adicionados com sucesso!',
                              ),
                              backgroundColor: Colors.green[900],
                            ),
                          );
                        } else if (successful == 0 ||
                            successful == -result.length) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
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
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Salvar Separados'),
                          Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        late FirebaseFireStoreResponse result;
                        if (cpfMask.unmaskedValue().isNotEmpty &&
                            cellphonMask.unmaskedValue().isNotEmpty) {
                          result = await fire.addMap(
                            map: {
                              'cpf_example': cpfMask.unmaskedValue(),
                              'cellphone_example': cellphonMask.unmaskedValue(),
                              'money_example':
                                  moneyMask.unmaskedToCurrency().toString(),
                            },
                          );
                          if (result.uploaded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Todos os dados foram adicionados com sucesso!',
                                ),
                                backgroundColor: Colors.green[900],
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Nenhum dado foi adicionado com sucesso.',
                                ),
                                backgroundColor: Colors.red[900],
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Campos vazios.',
                              ),
                              backgroundColor: Colors.red[900],
                            ),
                          );
                        }
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Salvar Todos'),
                          Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    fire.readAll();
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Read'),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
