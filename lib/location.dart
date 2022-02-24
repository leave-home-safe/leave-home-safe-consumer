// To parse this JSON data, do
//
//     final leaveHomeSafe = leaveHomeSafeFromJson(jsonString);

import 'dart:convert';

LeaveHomeSafe leaveHomeSafeFromJson(String str) =>
    LeaveHomeSafe.fromJson(json.decode(str));

String leaveHomeSafeToJson(LeaveHomeSafe data) => json.encode(data.toJson());

class LeaveHomeSafe {
  LeaveHomeSafe({
    required this.key,
    required this.location,
  });

  String key;
  String location;

  factory LeaveHomeSafe.fromJson(Map<String, dynamic> json) => LeaveHomeSafe(
        key: json["key"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "location": location,
      };
}
