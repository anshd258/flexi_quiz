import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexi_quiz/core/constants/typedef.dart';
import 'package:flexi_quiz/presentation/provider/authprovider/reposiotry/repository.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{
  AuthProvider(this.authrepository);
  
  AuthRepository authrepository;
  
  ResponseEither<UserCredential>? _user;
  ResponseEither<UserCredential>? get user => _user;
  
  final Stream<User?> _auth =  FirebaseAuth.instance.userChanges();
  Stream<User?> get streamAuth => _auth;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  Future<void> login({required String email,required String password})async{
    _isLoading = true;
    notifyListeners();

    final result = await authrepository.login(email, password);

    _user = result;
    _isLoading = false;
    notifyListeners();

  }

   Future<void> signup({required String name,required String email,required String password})async{
    _isLoading = true;
    notifyListeners();

    final result = await authrepository.signUp(name,email, password);

    _user = result;
    _isLoading = false;
    notifyListeners();

  }
  Future<void> logout()async{
    _isLoading = true;
    notifyListeners();

   await FirebaseAuth.instance.signOut();

    _isLoading = false;
    notifyListeners();

  }
}