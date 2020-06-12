import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_app_mad/Models/APPIPath.dart';
import 'package:time_tracker_app_mad/Models/Job.dart';
import 'package:time_tracker_app_mad/Models/User_firestore.dart';

abstract class Database {
  void createJob(Job job);
  void createUser(User_firestore userFirestore);
}

class FireStoreDatabase extends Database {
  final String uid;

  FireStoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) async => _setData(
  path: APIPath.job(uid, 'jobDocument'),
  data: job.toMap(),
  );

  Future<void> _setData ({String path, Map<String, dynamic> data}) async{
    final reference = Firestore.instance.document(path);
    print('$path : $data');
    await reference.setData(data);
  }

  @override
  Future<void> createUser(User_firestore userFirestore) async => _setData(
    path: APIPath.Userfirestore(uid, 'User_abc'),
    data: userFirestore.toMap(),
  );
}
