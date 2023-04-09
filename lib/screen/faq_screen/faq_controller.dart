import 'package:get/get.dart';

class FaqController extends GetxController {
  List<bool> selected = List.generate(5, (index) => false);
  onchange(index) {
    for (int i = 0; i < selected.length; i++) {
      if (i == index) {
        if (selected[i]) {
          selected[i] = false;
        } else {
          selected[i] = true;
        }
      } else {
        selected[i] = false;
      }
      update(['faq']);
    }
  }

  List data = [
    {'title': "data1", "description": 'description1'},
    {'title': "data2", "description": 'description2'},
    {'title': "data3", "description": 'description3'},
    {'title': "data4", "description": 'description4'},
    {'title': "data5", "description": 'description5'},
  ];
}
