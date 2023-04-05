import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:synchronized/extension.dart';

class EvertController {
  final dynamic address;
  final int port;
  EvertController({required this.address, required this.port});

  Socket? _s;
  Stream<String>? _stream;

  Future<void> _init() async => _s ??= await Socket.connect(address, port);

  Future<void> close() async {
    await _s?.close();
    _s = null;
  }

  Stream<Uint8List> _getStream() async* {
    await synchronized(_init);
    yield* _s!;
  }

  Stream<String> get stream => _stream ??= _getStream()
      .asyncExpand((event) => Stream.fromIterable(
          ascii.decode(event, allowInvalid: true).trim().split('\r')))
      .asBroadcastStream();

  Future<void> send(String command) async {
    await synchronized(_init);
    _s!.write(command);
  }
}
