import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart' as shelf;

import '../entity/order_status.dart';
import '../repo/iiko_operations.dart';
import '../repo/payment.dart';

class PaymeRequests {
  final PaymentRepo paymentRepo = PaymentRepo();
  final IIkoRepo iikoRepo = IIkoRepo();
  String orderId = '';
  String organizationId = '';
  String correlationId = '';

  String checkOperationResult(int state) {
    switch (state) {
      case 0:
        return 'Waiting';
      case 1:
        return 'Waiting';
      case 2:
        return 'Waiting';
      case 3:
        return 'Waiting';
      case 4:
        return 'Success';
      case 20:
        return 'Cancelled';
      case 21:
        return 'Cancelled';
      case 30:
        return 'Cancelled';
      case 50:
        return 'Cancelled';
      default:
        return 'Waiting';
    }
  }

  Future<void> checkPaymeOperationStatus(Timer timer, data) async {
    final paymeResultOfOperation = await paymentRepo.checkStatusOfPaymeOperation(id: data['id']);

    paymeResultOfOperation.fold((l) => {log('request checkStatusOfPaymeOperation  ${l.message}')}, (r) async {
      final state = checkOperationResult(r.result?.state ?? 0);
      if (state == 'Success') {
        timer.cancel();
        final createdOrder = await iikoRepo.makeOrder(data['body']);
        OrderStatus checkOrder = await iikoRepo.getStatusOfTheCommand(
            filialID: createdOrder.orderInfo.organizationId, correlationId: createdOrder.correlationId);
        int requestCounterForIiko = 0;
        organizationId = createdOrder.orderInfo.organizationId;
        correlationId = createdOrder.correlationId;
        while (checkOrder.state != 'Success' || requestCounterForIiko == 3) {
          checkOrder = await iikoRepo.getStatusOfTheCommand(
              filialID: createdOrder.orderInfo.organizationId, correlationId: createdOrder.correlationId);
          if (checkOrder.state == 'Success') {
            orderId = createdOrder.orderInfo.id;
            await iikoRepo.printBill(organizationId: organizationId, orderId: orderId);
            break;
          }
          requestCounterForIiko += 1;
          await Future.delayed(Duration(seconds: 8));
        }
      }
    });
  }

  Future<void> cancelPayment(body) async {
    final paymeResultOfOperation = await paymentRepo.cancelPayment(id: body['id']);
    paymeResultOfOperation.fold((l) => {log('request cancelPayment  ${l.message}')}, (r) async {
      if (r.result?.receipt?.state == 50) {
        await paymentRepo.sendNotification(body['phoneNumber']);
      } else {
        int passedSecondsForDeclineOperation = 0;
        Timer.periodic(Duration(seconds: 30), (Timer t) async {
          passedSecondsForDeclineOperation += 30;
          final paymeResult = await paymentRepo.checkStatusOfPaymeOperation(id: body['id']);
          paymeResult.fold((l) => {log('request checkStatusOfPaymeOperation  ${l.message}')}, (right) async {
            if (right.result?.state == 50 || passedSecondsForDeclineOperation >= 90) {
              t.cancel();
              passedSecondsForDeclineOperation = 0;
              await paymentRepo.sendNotification(body['phoneNumber']);
            }
          });
        });
      }
    });
  }

  Future<shelf.Response> paymePaymentStatus(shelf.Request request) async {
    final requestBody = await request.readAsString();

    final body = jsonDecode(requestBody);
    if (body['body'] != null && body['id'] != null) {
      int passedSeconds = 0;
      Timer.periodic(Duration(seconds: 30), (Timer timer) async {
        passedSeconds += 30;
        if (passedSeconds >= 300 && timer.isActive) {
          timer.cancel();
          cancelPayment(body);
        } else {
          checkPaymeOperationStatus(timer, body);
        }
      });
    } else {
      return shelf.Response.ok(jsonEncode({"result": "Error"}));
    }

    return shelf.Response.ok(jsonEncode({"result": "Success"}));
  }

  Future<shelf.Response> orderStatus(shelf.Request request, String id) async {
    final paymeResultOfOperation = await paymentRepo.checkStatusOfPaymeOperation(id: id);
    final result = await paymeResultOfOperation.fold((l) async {
      return shelf.Response.ok(jsonEncode({"result": "Canceled"}));
    }, (r) async {
      final state = checkOperationResult(r.result?.state ?? 0);
      if (state == 'Success') {
        OrderStatus checkOrder =
            await iikoRepo.getStatusOfTheCommand(filialID: organizationId, correlationId: correlationId);
        return shelf.Response.ok(jsonEncode({"result": checkOrder.state, "id": orderId}));
      } else if (state == 'Waiting') {
        return shelf.Response.ok(jsonEncode({"result": "In Progress"}));
      } else {
        return shelf.Response.ok(jsonEncode({"result": "Canceled"}));
      }
    });
    return result;
  }
}
