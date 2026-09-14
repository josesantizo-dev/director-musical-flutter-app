class UserEntity {
  final String id;
  final String email;
  final String name;
  final String firebaseUid;
  final String photoUrl;
  final bool isActive;
  final List<String> roles;
  final String accessToken;
  final String refreshToken;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.firebaseUid,
    required this.photoUrl,
    required this.isActive,
    required this.roles,
    required this.accessToken,
    required this.refreshToken,
  });
}
