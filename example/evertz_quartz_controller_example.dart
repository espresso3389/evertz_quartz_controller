import 'package:evertz_quartz_controller/evertz_quartz_controller.dart';

void main(List<String> arguments) async {
  final launchAt = DateTime.now();
  final ec = EvertController(address: '192.168.10.34', port: 3738);
  DateTime lastHeartbeat = DateTime.now();

  ec.stream.listen((event) {
    final d = DateTime.now().difference(launchAt);
    print('${d.toString()}: [$event]');
    lastHeartbeat = DateTime.now();
  });

  test(ec);

  while (true) {
    final now = DateTime.now();
    if (now.difference(lastHeartbeat) > Duration(seconds: 10)) {
      print('''************************************
EVERTZ FAILURE on $now (${now.difference(launchAt)})
************************************''');
      return;
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // for (int i = 49; i <= 64; i++) {
  //   await ec.send('.SV$i,$i\r');
  // }

  // for (int i = 49; i <= 64; i++) {
  //   await ec.send('.IV$i\r');
  // }

  // await ec.send('.SV${arguments[0]},${arguments[1]}\r');
  // print('${arguments[0]} -> ${arguments[1]}');
  // await ec.send('.IV${arguments[0]}\r');
}

Future<void> test(EvertController ec) async {
  const zoetAux = 1;
  const interval = Duration(milliseconds: 2000);
  const timeDelta = Duration(milliseconds: 100);
  final time0 = DateTime.now();
  int count = 0;
  while (true) {
    for (int i = 1; i <= 16; i++, count++) {
      //print('$zoetAux -> $i');
      await ec.send('.SV$zoetAux,$i\r');
      while (true) {
        final d = DateTime.now().difference(time0) - interval * count;
        if (d >= interval) break;
        await Future.delayed(timeDelta);
      }
    }
  }
}
