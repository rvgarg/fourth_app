class User {
  var email, name, img, phoneNo, dateOfBirth, id;

  User(
      {required this.email,
      required this.img,
      required this.dateOfBirth,
      required this.name,
      required this.phoneNo,
      required this.id});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        id: json['id'] ?? '',
        img: json['profile_img'] ?? '',
        email: json['email'] ?? '',
        dateOfBirth: json['last_login'] ?? '',
        name: json['name'] ?? '',
        phoneNo: json['contact_number'] ?? '');
  }
}
