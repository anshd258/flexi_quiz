import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexi_quiz/core/constants/typedef.dart';
import 'package:flexi_quiz/core/log/logger.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository {
  Future<ResponseEither<UserCredential>> signUp(
      String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(credential.user!.uid)
          .set({'name': name, 'email': email}).then(
        (value) {
          talker.info("doc created sucsfully");
        },
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        talker.error('The password provided is too weak.');
        return const Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        talker.error('The account already exists for that email.');
        return const Left('The account already exists for that email.');
      } else {
        talker.error(e.code);
        return Left(e.code);
      }
    } catch (e) {
      talker.error(e.toString());
      return Left(e.toString());
    }
  }

  Future<ResponseEither<UserCredential>> login(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        talker.error('No user found for that email.');
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        talker.error('Wrong password provided for that user.');
        return const Left('Wrong password provided for that user.');
      } else {
        talker.error(e.code);
        return Left(e.code);
      }
    } catch (e) {
      talker.error(e.toString());
      return Left(e.toString());
    }
  }
}
