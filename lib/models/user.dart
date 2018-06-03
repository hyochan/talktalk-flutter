class User  {
  String _id;
  String displayName;
  String email;
  String img;
  String statusMsg;

  DateTime createdAt;
  DateTime updatedAt;

  bool isPlaying = false;

  User()
      : _id = '',
        displayName = '',
        email = '',
        img = '',
        statusMsg = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now()
  ;

  User.initWithParams(String _id, String displayName, String email, String img, String statusMsg) {
    this._id = id;
    this.displayName = displayName;
    this.email = email;
    this.img = img;
    this.statusMsg = statusMsg;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}