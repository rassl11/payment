import 'package:json_annotation/json_annotation.dart';

part 'payme_cancel.g.dart';

@JsonSerializable()
class PaymeCancel {
  String? jsonrpc;
  int? id;
  Result? result;

  PaymeCancel({this.jsonrpc, this.id, this.result});

  factory PaymeCancel.fromJson(Map<String, dynamic> json) => _$PaymeCancelFromJson(json);
}

@JsonSerializable()
class Result {
  Receipt? receipt;

  Result({this.receipt});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@JsonSerializable()
class Receipt {
  String? sId;
  int? createTime;
  int? payTime;
  int? cancelTime;
  int? state;
  int? type;
  bool? external;
  int? operation;
  dynamic category;
  dynamic error;
  String? description;
  dynamic detail;
  int? amount;
  int? commission;
  List<Account>? account;
  dynamic card;
  Merchant? merchant;
  dynamic meta;

  Receipt(
      {this.sId,
      this.createTime,
      this.payTime,
      this.cancelTime,
      this.state,
      this.type,
      this.external,
      this.operation,
      this.category,
      this.error,
      this.description,
      this.detail,
      this.amount,
      this.commission,
      this.account,
      this.card,
      this.merchant,
      this.meta});

  factory Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);
}

@JsonSerializable()
class Account {
  String? name;
  String? title;
  String? value;

  Account({this.name, this.title, this.value});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}

@JsonSerializable()
class Merchant {
  String? sId;
  String? name;
  String? organization;
  String? address;
  Epos? epos;
  int? date;
  dynamic logo;
  String? type;
  dynamic terms;

  Merchant(
      {this.sId, this.name, this.organization, this.address, this.epos, this.date, this.logo, this.type, this.terms});

  factory Merchant.fromJson(Map<String, dynamic> json) => _$MerchantFromJson(json);
}

@JsonSerializable()
class Epos {
  String? merchantId;
  String? terminalId;

  Epos({this.merchantId, this.terminalId});

  factory Epos.fromJson(Map<String, dynamic> json) => _$EposFromJson(json);
}
