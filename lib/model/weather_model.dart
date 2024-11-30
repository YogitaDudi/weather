class WeatherModel {
  Location? location;
  Current? current;

  WeatherModel({this.location, this.current});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  String? localtime;

  Location({this.name, this.region, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['localtime'] = localtime;
    return data;
  }
}

class Current {
  double? tempC;
  Condition? condition;
  int? humidity;
  double? windKph;
  double? precipMm;

  Current({this.tempC, this.condition, this.humidity, this.windKph, this.precipMm});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null ? Condition.fromJson(json['condition']) : null;
    humidity = json['humidity'];
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp_c'] = tempC;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['humidity'] = humidity;
    data['wind_kph'] = windKph;
    data['precip_mm'] = precipMm;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['icon'] = icon;
    return data;
  }
}




