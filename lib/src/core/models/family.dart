class FamilyResponse {
  String message;
  List<Family> data;

  FamilyResponse({this.message, this.data});

  FamilyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Family.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Family {
  int id;
  String nama;
  String kelamin;
  int parentId;

  Family({this.id, this.nama, this.kelamin, this.parentId});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kelamin = json['kelamin'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['kelamin'] = this.kelamin;
    data['parentId'] = this.parentId;
    return data;
  }
}
