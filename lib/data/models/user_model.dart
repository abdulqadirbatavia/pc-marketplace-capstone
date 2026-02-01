class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? profileImageUrl;
  final DateTime joinedDate;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.profileImageUrl,
    required this.joinedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'joinedDate': joinedDate.toIso8601String(),
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      profileImageUrl: map['profileImageUrl'],
      joinedDate: DateTime.parse(map['joinedDate']),
    );
  }
}