import 'package:evertz_quartz_controller/evertz_quartz_controller.dart';

void main(List<String> arguments) async {
  final ec = EvertController(address: '192.168.10.34', port: 3738);

  ec.stream.listen((event) => print('[$event]'));

  for (int i = 49; i <= 64; i++) {
    await ec.send('.SV$i,$i\r');
  }

  for (int i = 49; i <= 64; i++) {
    await ec.send('.IV$i\r');
  }
}
