class CustomUser {
  String _uid;
  String _name;
  String _email;

  CustomUser(this._uid, this._name, this._email);


  String get email => _email;

  String get name => _name;

  String get uid => _uid;

  // Used to convert a user object into a map / json
  Map<String, dynamic> toJson() => {
    'uid': _uid,
    'name': _name,
    'email': _email,
  };
}