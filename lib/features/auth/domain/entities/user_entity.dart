import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String role; // 'client' ou 'barber'

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.role = 'client',
  });

  @override
  List<Object?> get props => [uid, name, email, photoUrl, role];
}
