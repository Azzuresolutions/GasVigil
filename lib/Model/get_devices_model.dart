class GetDevicesModel {
  int? id;
  String? deviceId;
  String? userEmail;
  String? userPhone;
  String? name;
  String? description;
  String? registeredAt;
  int? alertStatus;

  GetDevicesModel(
      {id,
      deviceId,
      userEmail,
      userPhone,
      name,
      description,
      registeredAt,
      alertStatus});

  GetDevicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    name = json['name'];
    description = json['description'];
    registeredAt = json['registeredAt'];
    alertStatus = json['alertStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceId'] = deviceId;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['name'] = name;
    data['description'] = description;
    data['registeredAt'] = registeredAt;
    return data;
  }
}
