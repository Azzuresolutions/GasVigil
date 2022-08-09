class DashBoardModel {
  int? deviceCount;
  int? alertsCount;
  List<Devices>? devices;
  List<Alerts>? alerts;

  DashBoardModel(
      {deviceCount, alertsCount, devices, alerts});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    deviceCount = json['deviceCount'];
    alertsCount = json['alertsCount'];
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add( Devices.fromJson(v));
      });
    }
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) {
        alerts!.add( Alerts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['deviceCount'] = deviceCount;
    data['alertsCount'] = alertsCount;
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    if (alerts != null) {
      data['alerts'] = alerts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Devices {
  int? id;
  String? deviceId;
  String? userEmail;
  int? userPhone;
  String? name;
  String? description;
  String? registeredAt;

  Devices(
      {id,
      deviceId,
      userEmail,
      userPhone,
      name,
      description,
      registeredAt});

  Devices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    name = json['name'];
    description = json['description'];
    registeredAt = json['registeredAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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

class Alerts {
  String? id;

  Alerts({id});

  Alerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}


class GetAlertsModel {
  int? id;
  Device? device;
  int? deviceId;
  String? created;
  String? updated;
  String? closed;
  int? status;
  int? closingReason;
  String? notes;

  GetAlertsModel(
      {this.id,
      this.device,
      this.deviceId,
      this.created,
      this.updated,
      this.closed,
      this.status,
      this.closingReason,
      this.notes});

  GetAlertsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
    deviceId = json['deviceId'];
    created = json['created'];
    updated = json['updated'];
    closed = json['closed'];
    status = json['status'];
    closingReason = json['closingReason'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    data['deviceId'] = this.deviceId;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['closed'] = this.closed;
    data['status'] = this.status;
    data['closingReason'] = this.closingReason;
    data['notes'] = this.notes;
    return data;
  }
}

class Device {
  int? id;
  String? deviceId;
  String? dateCreated;
  String? lastboottime;
  String? dateSetup;
  String? lastacktime;
  String? lasthealthtime;
  bool? mute;
  bool? showAlert;
  int? status;
  bool? isAssigned;

  Device(
      {this.id,
      this.deviceId,
      this.dateCreated,
      this.lastboottime,
      this.dateSetup,
      this.lastacktime,
      this.lasthealthtime,
      this.mute,
      this.showAlert,
      this.status,
      this.isAssigned});

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    dateCreated = json['dateCreated'];
    lastboottime = json['lastboottime'];
    dateSetup = json['dateSetup'];
    lastacktime = json['lastacktime'];
    lasthealthtime = json['lasthealthtime'];
    mute = json['mute'];
    showAlert = json['showAlert'];
    status = json['status'];
    isAssigned = json['isAssigned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deviceId'] = this.deviceId;
    data['dateCreated'] = this.dateCreated;
    data['lastboottime'] = this.lastboottime;
    data['dateSetup'] = this.dateSetup;
    data['lastacktime'] = this.lastacktime;
    data['lasthealthtime'] = this.lasthealthtime;
    data['mute'] = this.mute;
    data['showAlert'] = this.showAlert;
    data['status'] = this.status;
    data['isAssigned'] = this.isAssigned;
    return data;
  }
}
