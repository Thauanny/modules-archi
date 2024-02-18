import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firebase_service.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/model/firebase_response.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';

class FirebaseServiceImpl implements FirebaseService {
  final CollectionReference exampleNotes =
      FirebaseFirestore.instance.collection('exampleNotes');

  @override
  Future<FirebaseResponse> add(
      {required String key, required String value}) async {
    if (key.isNotEmpty && value.isNotEmpty) {
      try {
        var documentReference = await exampleNotes.add({
          key: value,
          'timestamp': Timestamp.now(),
        });
        debugPrintHelper(
            'Documento adicionado com ID: ${documentReference.id}');
        return FirebaseResponse(
          uploaded: true,
          key: key,
          id: documentReference.id,
        );
      } catch (e) {
        debugPrintHelper('Erro ao adicionar documento: $e');
        return FirebaseResponse(
          uploaded: false,
          key: key,
          id: '',
        );
      }
    } else {
      return FirebaseResponse(
        uploaded: false,
        key: key,
        id: '',
      );
    }
  }
}
