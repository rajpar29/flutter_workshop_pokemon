class Pokemon {
  String name;
  List type;
  String height;
  String weight;
  String imageUrl;
  Pokemon({
    this.name,
    this.type,
    this.height,
    this.weight,
    this.imageUrl
  });
  

  Pokemon.fromMap(Map snapshot){
    name = snapshot["name"];
    type = snapshot["type"];
    height = snapshot["height"];
    weight = snapshot["weight"];
    imageUrl = snapshot["imageUrl"];
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'height': height,
      'weight': weight,
      'imageUrl': imageUrl
    };
  }

  @override
  String toString() {
    return 'Pokemon name: $name, type: $type, height: $height, weight: $weight, imageUrl: $imageUrl';
  }
}