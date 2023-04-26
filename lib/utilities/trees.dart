class TreeModel {
  static List<Tree> tree = [];
}

class Tree {
  final num id;
  final String name;
  final String description;
  final String soil;

  Tree(
      {required this.id,
      required this.name,
      required this.description,
      required this.soil});

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        soil: json["soil"]);
  }

  toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "soil": soil,
      };
}
