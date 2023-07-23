import 'package:evertz_quartz_controller/evertz_quartz_controller.dart';

void main(List<String> arguments) async {
  final launchAt = DateTime.now();
  final ec = EvertController(address: '192.168.10.34', port: 3739);
  DateTime lastHeartbeat = DateTime.now();

  ec.stream.listen((event) {
    final d = DateTime.now().difference(launchAt);
    print('${d.toString()}: [$event]');
    lastHeartbeat = DateTime.now();
  });

  // for (int i = 49; i <= 64; i++) {
  //   await ec.send('.SV$i,$i\r');
  // }

  for (int i = 1; i <= 64; i++) {
    await ec.send('.IV$i\r');
  }

  const dest = 58; // 58=MONI
  const src = 35; // 33=STB,34=OtherPC1,...

  await ec.send('.SV$dest,$src\r');
  print('$dest -> $src');
  await ec.send('.IV$dest\r');
}

Future<void> test(
  EvertController ec, {
  int dest = 64,
  Duration interval = const Duration(seconds: 2),
}) async {
  const timeDelta = Duration(milliseconds: 100);
  final time0 = DateTime.now();
  int count = 0;
  while (true) {
    for (int i = 1; i <= 16; i++, count++) {
      await ec.send('.SV$dest,$i\r');
      while (true) {
        final d = DateTime.now().difference(time0) - interval * count;
        if (d >= interval) break;
        await Future.delayed(timeDelta);
      }
    }
  }
}
