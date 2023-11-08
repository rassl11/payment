import 'package:json_annotation/json_annotation.dart';

part 'order_status.g.dart';

@JsonSerializable()
class OrderStatus {
  String state;
  OrderStatus(this.state);

  factory OrderStatus.fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
}
