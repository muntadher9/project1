class AppUser {
  const AppUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.role = 'owner',
    this.branchIds = const [],
  });

  final String uid;
  final String email;
  final String? displayName;
  final String role;
  final List<String> branchIds;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'branchIds': branchIds,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      uid: data['uid'] as String,
      email: data['email'] as String,
      displayName: data['displayName'] as String?,
      role: data['role'] as String? ?? 'owner',
      branchIds: (data['branchIds'] as List<dynamic>? ?? const [])
          .cast<String>(),
    );
  }
}
