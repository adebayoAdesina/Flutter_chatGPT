class BaseModel {
  String? id;
  int? created;
  String? root;

  BaseModel({
    this.created,
    this.id,
    this.root,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        id: json['id'],
        created: json['created'],
        root: json['root'],
      );

  static List<BaseModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((e) => BaseModel.fromJson(e)).toList();
  }
}
