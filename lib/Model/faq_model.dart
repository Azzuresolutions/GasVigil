class FaqModel {
  int? id;
  String? question;
  String? answer;
  bool? isActive;

  FaqModel({this.id, this.question, this.answer, this.isActive});

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['isActive'] = isActive;
    return data;
  }
}
