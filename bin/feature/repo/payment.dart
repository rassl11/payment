import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/errors/failure.dart';
import '../entity/payme_cancel.dart';
import '../entity/payme_status.dart';

class PaymentRepo {
  Future<Either<Failure, PaymeStatus>> checkStatusOfPaymeOperation({required String id}) async {
    try {
      final response = await http
          .post(Uri.parse('https://checkout.paycom.uz/api'),
              headers: {
                "X-Auth": "6512be942918d26924fd1720:q7kC9roSZR0Ur1P4bJUf&wZr&#Z7vxNrI9e?",
                "Content-Type": "application/json",
              },
              body: jsonEncode({
                "id": 4,
                "method": "receipts.check",
                "params": {"id": id}
              }));
      if (response.statusCode == 200) {
        return Right(PaymeStatus.fromJson(jsonDecode(response.body)));
      } else {
        return Left(Failure(message: 'Error, ${response.body}'));
      }
    } catch (e, s) {
      log('stacktrace - $s, ${e.toString()} checkStatusOfPaymeOperation request, paymeId - $id');
      return Left(Failure(message: 'Error, $e'));
    }
  }

  Future<Either<Failure, PaymeCancel>> cancelPayment({required String id}) async {
    try {
      final response = await http.post(Uri.parse('https://checkout.paycom.uz/api'),
          headers: {
            "X-Auth": "6512be942918d26924fd1720:q7kC9roSZR0Ur1P4bJUf&wZr&#Z7vxNrI9e?",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "id": 4,
            "method": "receipts.cancel",
            "params": {"id": id}
          }));
      if (response.statusCode == 200) {
        return Right(PaymeCancel.fromJson(jsonDecode(response.body)));
      } else {
        log('Error cancelPayment id-$id, ${response.body}');
        return Left(Failure(message: 'Error, ${response.body}'));
      }
    } catch (e, s) {
      log('stacktrace - $s, ${e.toString()} cancelPayment request, paymeId - $id');
      return Left(Failure(message: 'Error'));
    }
  }

  Future<void> sendNotification(String? phoneNumber) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';

    final data = {
      "notification": {
        "body": 'Ваш заказ был отменен',
        "title": 'Sariq Bola',
        "sound": 'default',
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "screen": "second",
        "sound": 'default',
      },
      "to": '/topics/$phoneNumber'
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAARIRUnWQ:APA91bGg8ejIAdeiJnLNl8S8DPi5ZLJOthf-TJTdbD2VV52rX1FhOb-akQlpDpaCvdKmnXdstP6vdB0CoKH_fzQUyPLH7lM53KhI8bWRex2PFCG3pqje4fxlgHz4Jp9zTan79-M6TqQz'
    };
    try {
      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data), encoding: Encoding.getByName('utf-8'), headers: headers);

      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }
}
