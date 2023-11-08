import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../entity/api_token.dart';
import '../entity/create_order.dart';
import '../entity/order_status.dart';

class IIkoRepo {
  Future<OrderStatus> getStatusOfTheCommand({required String filialID, required String? correlationId}) async {
    try {
      final newTokenPost = await http.post(
        Uri.parse('https://api-ru.iiko.services/api/1/access_token'),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{"apiLogin": "2740441b-c6f"}),
      );
      final newToken = ApiToken.fromJson(jsonDecode(newTokenPost.body));
      final response = await http.post(Uri.parse('https://api-ru.iiko.services/api/1/commands/status'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${newToken.token}',
          },
          body: jsonEncode(<String, dynamic>{"organizationId": filialID, "correlationId": correlationId}));

      if (response.statusCode == 200) {
        return OrderStatus.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<CreateOrder> makeOrder(body) async {
    try {
      final newTokenPost = await http.post(
        Uri.parse('https://api-ru.iiko.services/api/1/access_token'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "apiLogin": "2740441b-c6f",
        }),
      );
      final newToken = ApiToken.fromJson(jsonDecode(newTokenPost.body));

      final response = await http.post(Uri.parse('https://api-ru.iiko.services/api/1/deliveries/create'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${newToken.token}',
          },
          body: jsonEncode(body));

      switch (response.statusCode) {
        case 200:
          return CreateOrder.fromJson(jsonDecode(response.body));
        case 400 || 401 || 408 || 500:
          throw const HttpException('');
        default:
          throw const SocketException('');
      }
    } on SocketException catch (_) {
      throw const SocketException('Нет интернета');
    } on HttpException catch (_) {
      throw const HttpException('Проблемы с сервером');
    } catch (e) {
      throw Exception('Неизвестаня ошибка');
    }
  }

  Future<void> printBill({required String organizationId, required String orderId}) async {
    String token = '';
    try {
      final newTokenPost = await http.post(
        Uri.parse('https://api-ru.iiko.services/api/1/access_token'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "apiLogin": "2740441b-c6f",
        }),
      );
      final newToken = ApiToken.fromJson(jsonDecode(newTokenPost.body));

      final response = await http.post(Uri.parse('https://api-ru.iiko.services/api/1/deliveries/print_delivery_bill'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${newToken.token}',
          },
          body: jsonEncode(<String, dynamic>{"organizationId": organizationId, "orderId": orderId}));

      switch (response.statusCode) {
        case 200:
          log('Print bill success ${response.body}');
      }
    } catch (e) {
      log('Print bill fail ${e.toString()}');
    }
  }
}
