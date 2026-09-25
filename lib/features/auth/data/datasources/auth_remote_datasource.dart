import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:barber_flow/core/constants/app_constants.dart';
import 'package:barber_flow/core/error/exceptions.dart';
import 'package:barber_flow/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String name, String email, String password);
  Future<void> resetPassword(String email);
  Future<UserModel?> getCurrentUser();
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firestore,
    this._googleSignIn,
  );

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      User? user;
      
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        user = userCredential.user;
      } else {
        // google_sign_in v7 API: authenticate() retorna GoogleSignInAccount
        // e lança GoogleSignInException em caso de erro/cancelamento
        final googleUser = await _googleSignIn.authenticate();
        
        if (googleUser == null) {
          throw const ServerException('Login com Google cancelado pelo usuário');
        }

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        final userCredential = await _firebaseAuth.signInWithCredential(credential);
        user = userCredential.user;
      }

      if (user == null) {
        throw const ServerException('Usuário não encontrado após login');
      }

      final userModel = UserModel.fromFirebaseUser(user);
      // Salva no background para não travar a tela de "Entrando..." na web
      _saveUserToFirestore(userModel);

      return userModel;
    } on ServerException {
      rethrow;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const ServerException('Login com Google cancelado pelo usuário');
      }
      throw ServerException('Erro no Google Sign-In: ${e.code}');
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseAuthError(e.code));
    } catch (e) {
      throw ServerException('Erro ao fazer login com Google: $e');
    }
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = userCredential.user;

      if (user == null) {
        throw const ServerException('Usuário não encontrado após login');
      }

      // Busca dados completos do Firestore (inclui role, nome atualizado, etc.)
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return UserModel.fromFirebaseUser(user);
    } on ServerException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseAuthError(e.code));
    } catch (e) {
      throw ServerException('Erro ao fazer login: $e');
    }
  }

  @override
  Future<UserModel> signUpWithEmail(String name, String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = userCredential.user;

      if (user == null) {
        throw const ServerException('Erro ao criar conta');
      }

      // Atualiza o displayName no Firebase Auth
      await user.updateDisplayName(name.trim());

      final userModel = UserModel(
        uid: user.uid,
        name: name.trim(),
        email: email.trim(),
        photoUrl: user.photoURL,
      );

      await _saveUserToFirestore(userModel);

      return userModel;
    } on ServerException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseAuthError(e.code));
    } catch (e) {
      throw ServerException('Erro ao criar conta: $e');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseAuthError(e.code));
    } catch (e) {
      throw ServerException('Erro ao enviar e-mail de recuperação: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      throw ServerException('Erro ao verificar autenticação: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw ServerException('Erro ao fazer logout: $e');
    }
  }

  // -- Helpers --

  Future<void> _saveUserToFirestore(UserModel user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.uid)
        .set(user.toMap(), SetOptions(merge: true));
  }

  String _mapFirebaseAuthError(String code) {
    return switch (code) {
      'user-not-found' => 'Nenhuma conta encontrada com este e-mail',
      'wrong-password' => 'Senha incorreta',
      'invalid-credential' => 'E-mail ou senha incorretos',
      'email-already-in-use' => 'Este e-mail já está em uso',
      'weak-password' => 'A senha é muito fraca (mínimo 6 caracteres)',
      'invalid-email' => 'E-mail inválido',
      'user-disabled' => 'Esta conta foi desativada',
      'too-many-requests' => 'Muitas tentativas. Tente novamente mais tarde',
      'operation-not-allowed' => 'Método de login não habilitado',
      'network-request-failed' => 'Sem conexão com a internet',
      _ => 'Erro de autenticação ($code)',
    };
  }
}
