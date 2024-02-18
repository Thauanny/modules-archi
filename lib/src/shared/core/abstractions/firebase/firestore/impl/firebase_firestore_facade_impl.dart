import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/firebase_firestore_facade.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase/firestore/model/firebase_response.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';

class FirebaseFireStoreFacadeImpl implements FirebaseFireStoreFacade {
  final CollectionReference exampleNotes =
      FirebaseFirestore.instance.collection('exampleNotes');

  @override
  Future<FirebaseFireStoreResponse> add({
    required String key,
    required String value,
  }) async {
    if (key.isNotEmpty && value.isNotEmpty) {
      try {
        var documentReference = await exampleNotes.add({
          key: value,
          'timestamp': Timestamp.now(),
        });
        debugPrintHelper(
            'Documento adicionado com ID: ${documentReference.id}');
        return FirebaseFireStoreResponse(
          uploaded: true,
          data: key,
          id: documentReference.id,
        );
      } catch (e) {
        debugPrintHelper('Erro ao adicionar documento: $e');
        return FirebaseFireStoreResponse(
          uploaded: false,
          data: key,
          id: '',
        );
      }
    } else {
      return FirebaseFireStoreResponse(
        uploaded: false,
        data: key,
        id: '',
      );
    }
  }

  @override
  Future<FirebaseFireStoreResponse> addMap({
    required Map<String, dynamic> map,
  }) async {
    if (map.isNotEmpty) {
      try {
        map.addAll({
          'timestamp': Timestamp.now(),
        });
        var documentReference = await exampleNotes.add(map);
        debugPrintHelper(
            'Documento adicionado com ID: ${documentReference.id}, data: $map');
        return FirebaseFireStoreResponse(
          uploaded: true,
          data: map,
          id: documentReference.id,
        );
      } catch (e) {
        debugPrintHelper('Erro ao adicionar documento: $e');
        return FirebaseFireStoreResponse(
          uploaded: false,
          data: map,
          id: '',
        );
      }
    } else {
      return FirebaseFireStoreResponse(
        uploaded: false,
        data: map,
        id: '',
      );
    }
  }

  @override
  Future<void> readAll() async {
    try {
      QuerySnapshot querySnapshot = await exampleNotes
          .orderBy(
            'timestamp',
            descending: true,
          )
          .get();

      for (var document in querySnapshot.docs) {
        debugPrintHelper('ID do documento: ${document.id}');
        var data = document.data();
        debugPrintHelper('Dados do documento: $data');
      }
    } catch (e) {
      debugPrintHelper('Erro ao buscar todos os documentos: $e');
    }
  }

  @override
  Future<void> readById({required String idDocument}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await exampleNotes.doc(idDocument).get();

      if (documentSnapshot.exists) {
        debugPrintHelper('Dados do documento: ${documentSnapshot.data()}');
      } else {
        debugPrintHelper('O documento não existe.');
      }
    } catch (e) {
      debugPrintHelper('Erro ao buscar o documento: $e');
    }
  }

  @override
  Future<void> readWhere({required String key, required String value}) async {
    QuerySnapshot querySnapshot = await exampleNotes
        .where(key, isEqualTo: value)
        .orderBy(
          'timestamp',
          descending: true,
        )
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      //TODO devolver lista
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      debugPrintHelper('Dados do documento: ${documentSnapshot.data()}');
    } else {
      debugPrintHelper('Nenhum documento encontrado.');
    }
  }

  @override
  Future<void> update({
    required String idDocument,
    bool merge = false,
    required Map<String, dynamic> data,
  }) async {
    try {
      DocumentReference documentRef = exampleNotes.doc(idDocument);

      await documentRef.set(data, SetOptions(merge: merge));

      debugPrintHelper(
        'Documento atualizado com sucesso! ID: ${documentRef.id}',
      );
    } catch (e) {
      debugPrintHelper('Erro ao atualizar o documento: $e');
    }
  }

  Future<void> deleteById({
    required String idDocument,
  }) async {
    try {
      DocumentReference documentRef = exampleNotes.doc(idDocument);

      await documentRef.delete();

      debugPrintHelper(
        'Documento excluído com sucesso! ID: ${documentRef.id}',
      );
    } catch (e) {
      debugPrintHelper('Erro ao excluir o documento: $e');
    }
  }
}
