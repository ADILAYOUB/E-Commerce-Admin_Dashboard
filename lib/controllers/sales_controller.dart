import 'package:get/get.dart';


class SalesController extends GetxController {

  // getting and creating dummy data, you can use api or database
  Future<List<Map<String, dynamic>>> fetchData() async {
    return List.generate(
        5,
            (index) =>
        {
          'salesId': 'Sale $index',
          'totalAmount': '\$${(index + 1) * 2000}',
          'orderCount': (index + 1) * 145,
          'date': '2025-3-1${index + 1}',
          'growth': '${(index + 1) * 4}%'


        });
  }
}