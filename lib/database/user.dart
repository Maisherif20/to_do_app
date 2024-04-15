class UserApp {
  String? id;
  String? fullNmae;
  String? userName;
  String? email;

  UserApp({this.id, this.fullNmae, this.userName, this.email});

  //pass data as map to fire store
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'fullName': fullNmae,
      'userName': userName,
      'email': email
    };
  }

//convert map of data to object
  UserApp.fromFireStore(Map<String, dynamic>? data) :this(
    id: data?['id'],
    fullNmae: data?['fullName'],
    userName: data?['userName'],
    email: data?['email'],
  );
}


