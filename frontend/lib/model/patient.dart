    // "_id": "67da66cfe3a30787910e6ce7",
    // "name": "Rickie Au",
    // "age": 24,
    // "gender": "Male",
    // "address": "937 Progress Ave",
    // "zipCode": "M1G 3T8",
    // "profilePicture": "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png",
    // "condition": "Normal",
    // "updatedAt": "2025-04-15T13:47:42.286Z",

class Patient {

  String? id;
  String? name;
  int? age;
  String? gender;
  String? address;
  final String zipCode;
  final String profilePicture;
  final String condition;
  DateTime updatedAt;




  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.zipCode,
    required this.profilePicture,
    required this.condition,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      address: json['address'],
      zipCode: json['zipCode'],
      profilePicture: json['profilePicture'],
      condition: json['condition'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  static List<Patient> todoList() {
    return [
      Patient(id: '01', name: "Rickie", age: 24, gender: "Male", address: "937 Progress Ave", zipCode: "M1G 3T8", profilePicture: "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png", condition: "Normal", updatedAt: DateTime.now()),
      Patient(id: '02', name: "Rickie", age: 24, gender: "Male", address: "937 Progress Ave", zipCode: "M1G 3T8", profilePicture: "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png", condition: "Normal", updatedAt: DateTime.now()),
      Patient(id: '03', name: "Rickie", age: 24, gender: "Male", address: "937 Progress Ave", zipCode: "M1G 3T8", profilePicture: "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png", condition: "Normal", updatedAt: DateTime.now()),
      Patient(id: '04', name: "Rickie", age: 24, gender: "Male", address: "937 Progress Ave", zipCode: "M1G 3T8", profilePicture: "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png", condition: "Normal", updatedAt: DateTime.now()),
      Patient(id: '05', name: "Rickie", age: 24, gender: "Male", address: "937 Progress Ave", zipCode: "M1G 3T8", profilePicture: "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png", condition: "Normal", updatedAt: DateTime.now()),
      Patient(id: '06', name: "Rickie", age: 24, gender: "Male", address: "937 Progress Ave", zipCode: "M1G 3T8", profilePicture: "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png", condition: "Normal", updatedAt: DateTime.now()),
    ];
  }
}