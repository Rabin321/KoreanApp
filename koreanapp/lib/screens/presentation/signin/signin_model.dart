class Login {
  final String uid;
  final String email;
  final String name;
  final String phone; // New field for correct answer index

  Login({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
  });

  @override
  String toString() {
    return 'Login(uid:$uid,title:$email,optionsImageUrl:$name,correctAnswer:$phone)';
  }
}
