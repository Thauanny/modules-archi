import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/firebase_firestore_facade.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/impl/firebase_firestore_facade_impl.dart';
import 'package:get_it/get_it.dart';

class FirebaseModule extends StatefulWidget {
  FirebaseModule({super.key}) {
    GetIt.I.registerSingleton<FirebaseFireStoreFacade>(
      FirebaseFireStoreFacadeImpl(),
    );
  }

  @override
  State<FirebaseModule> createState() => _FirebaseModuleState();
}

class _FirebaseModuleState extends State<FirebaseModule> {
  @override
  void dispose() {
    GetIt.I.unregister<FirebaseFireStoreFacade>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
