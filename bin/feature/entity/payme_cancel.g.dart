// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payme_cancel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymeCancel _$PaymeCancelFromJson(Map<String, dynamic> json) => PaymeCancel(
      jsonrpc: json['jsonrpc'] as String?,
      id: json['id'] as int?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymeCancelToJson(PaymeCancel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      receipt: json['receipt'] == null
          ? null
          : Receipt.fromJson(json['receipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'receipt': instance.receipt,
    };

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      sId: json['sId'] as String?,
      createTime: json['createTime'] as int?,
      payTime: json['payTime'] as int?,
      cancelTime: json['cancelTime'] as int?,
      state: json['state'] as int?,
      type: json['type'] as int?,
      external: json['external'] as bool?,
      operation: json['operation'] as int?,
      category: json['category'],
      error: json['error'],
      description: json['description'] as String?,
      detail: json['detail'],
      amount: json['amount'] as int?,
      commission: json['commission'] as int?,
      account: (json['account'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
      card: json['card'],
      merchant: json['merchant'] == null
          ? null
          : Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
      meta: json['meta'],
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'sId': instance.sId,
      'createTime': instance.createTime,
      'payTime': instance.payTime,
      'cancelTime': instance.cancelTime,
      'state': instance.state,
      'type': instance.type,
      'external': instance.external,
      'operation': instance.operation,
      'category': instance.category,
      'error': instance.error,
      'description': instance.description,
      'detail': instance.detail,
      'amount': instance.amount,
      'commission': instance.commission,
      'account': instance.account,
      'card': instance.card,
      'merchant': instance.merchant,
      'meta': instance.meta,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      name: json['name'] as String?,
      title: json['title'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'value': instance.value,
    };

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
      sId: json['sId'] as String?,
      name: json['name'] as String?,
      organization: json['organization'] as String?,
      address: json['address'] as String?,
      epos: json['epos'] == null
          ? null
          : Epos.fromJson(json['epos'] as Map<String, dynamic>),
      date: json['date'] as int?,
      logo: json['logo'],
      type: json['type'] as String?,
      terms: json['terms'],
    );

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'sId': instance.sId,
      'name': instance.name,
      'organization': instance.organization,
      'address': instance.address,
      'epos': instance.epos,
      'date': instance.date,
      'logo': instance.logo,
      'type': instance.type,
      'terms': instance.terms,
    };

Epos _$EposFromJson(Map<String, dynamic> json) => Epos(
      merchantId: json['merchantId'] as String?,
      terminalId: json['terminalId'] as String?,
    );

Map<String, dynamic> _$EposToJson(Epos instance) => <String, dynamic>{
      'merchantId': instance.merchantId,
      'terminalId': instance.terminalId,
    };
