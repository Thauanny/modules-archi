import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/firebase_firestore_facade.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/impl/firebase_firestore_facade_impl.dart';
import 'package:get_it/get_it.dart';

abstract class FirebaseModule<T extends StatefulWidget> extends State<T> {
  FirebaseModule() {
    GetIt.I.registerSingleton<FirebaseFireStoreFacade>(
      FirebaseFireStoreFacadeImpl(),
    );
  }
  @override
  void dispose() {
    GetIt.I.unregister<FirebaseFireStoreFacade>();
    super.dispose();
  }
}
