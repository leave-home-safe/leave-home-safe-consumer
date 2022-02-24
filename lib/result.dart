// To parse this JSON data, do
//
//     final leaveHomeSafeResult = leaveHomeSafeResultFromJson(jsonString);

import 'dart:convert';

LeaveHomeSafeResult leaveHomeSafeResultFromJson(String str) =>
    LeaveHomeSafeResult.fromJson(json.decode(str));

String leaveHomeSafeResultToJson(LeaveHomeSafeResult data) =>
    json.encode(data.toJson());

class LeaveHomeSafeResult {
  LeaveHomeSafeResult({
    required this.vaccinated,
    required this.visitedAt,
  });

  bool vaccinated;
  DateTime visitedAt;

  factory LeaveHomeSafeResult.fromJson(Map<String, dynamic> json) =>
      LeaveHomeSafeResult(
        vaccinated: json["vaccinated"],
        visitedAt: DateTime.parse(json["visited_at"]),
      );

  Map<String, dynamic> toJson() => {
        "vaccinated": vaccinated,
        "visited_at":
            "${visitedAt.year.toString().padLeft(4, '0')}-${visitedAt.month.toString().padLeft(2, '0')}-${visitedAt.day.toString().padLeft(2, '0')}",
      };
}
