import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'feature/requests/payme_request.dart';

final PaymeRequests requests = PaymeRequests();

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "*",
};

final _router = Router()
  ..get('/order-status/<id>', requests.orderStatus)
  ..post('/payme-start', requests.paymePaymentStatus);

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  Response _cors(Response response) => response.change(headers: corsHeaders);
  Response? _options(Request request) => (request.method == "OPTIONS") ? Response.ok(null, headers: corsHeaders) : null;
  final _fixCORS = createMiddleware(requestHandler: _options, responseHandler: _cors);

  final handler = Pipeline().addMiddleware(logRequests()).addMiddleware(_fixCORS).addHandler(_router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await shelf_io.serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
