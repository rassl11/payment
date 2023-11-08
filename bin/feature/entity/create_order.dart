class CreateOrder {
  CreateOrder({
    required this.correlationId,
    required this.orderInfo,
  });
  String correlationId;
  OrderInfo orderInfo;

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
        correlationId: json["correlationId"],
        orderInfo: OrderInfo.fromJson(json["orderInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "correlationId": correlationId,
        "orderInfo": orderInfo.toJson(),
      };
}

class OrderInfo {
  OrderInfo({
    required this.id,
    required this.organizationId,
    required this.timestamp,
    required this.creationStatus,
    required this.errorInfo,
    required this.order,
  });

  String id;
  String organizationId;
  int timestamp;
  String creationStatus;
  dynamic errorInfo;
  Order? order;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        id: json["id"],
        organizationId: json["organizationId"],
        timestamp: json["timestamp"],
        creationStatus: json["creationStatus"],
        errorInfo: json["errorInfo"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organizationId": organizationId,
        "timestamp": timestamp,
        "creationStatus": creationStatus,
        "errorInfo": errorInfo,
        "order": order,
      };
}

class Order {
  int number;
  Order({required this.number});

  factory Order.fromJson(Map<String, dynamic> json) => Order(number: json["number"]);
}

class Product {
  String name;

  Product({required this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(name: json['json']);
  }
}
