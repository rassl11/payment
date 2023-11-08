// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payme_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymeStatus _$PaymeStatusFromJson(Map<String, dynamic> json) => PaymeStatus(
      jsonrpc: json['jsonrpc'] as String?,
      id: json['id'] as int?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymeStatusToJson(PaymeStatus instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      state: json['state'] as int?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'state': instance.state,
    };
