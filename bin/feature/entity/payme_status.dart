import 'package:json_annotation/json_annotation.dart';

part 'payme_status.g.dart';

@JsonSerializable()
class PaymeStatus {
  String? jsonrpc;
  int? id;
  Result? result;

  PaymeStatus({this.jsonrpc, this.id, this.result});

  factory PaymeStatus.fromJson(Map<String, dynamic> json) => _$PaymeStatusFromJson(json);
}

@JsonSerializable()
class Result {
  int? state;

  Result({this.state});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
