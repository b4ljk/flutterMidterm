class Person {
  String name;
  String phoneNumber;
  String imageUrl;

  Person(
      {required this.name, required this.phoneNumber, required this.imageUrl});

  Person.fromJson(Map<String, dynamic> json)
      : name =
            "${json["name"]["title"]} ${json["name"]["first"]} ${json["name"]["last"]}",
        phoneNumber = json["phone"],
        imageUrl = json["picture"]["thumbnail"];
}
