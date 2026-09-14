import 'package:director_musical_app/features/auth/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity jsonToEntity(Map<String, dynamic> json) => UserEntity(
    id: json['user']['id'],
    email: json['user']['email'],
    name: json['user']['name'],
    firebaseUid: json['user']['firebaseUid'],
    photoUrl: json['user']['photoUrl'],
    isActive: json['user']['isActive'],
    roles: List<String>.from(json['user']['roles'] ?? []),
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
  );
}
