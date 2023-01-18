// ignore_for_file: public_member_api_docs, sort_constructors_first
/// The User class is a Dart class that has four properties: uid, displayName, email, and photoURL.
class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  AppUser({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoURL,
  });

  factory AppUser.empty() {
    return AppUser(uid: '', displayName: '', email: '');
  }
}
