import 'package:get/get.dart';


class OrderController extends GetxController {

  // getting and creating dummy data, you can use api or database
  Future<List<Map<String, dynamic>>> fetchData() async {
    return List.generate(
        5,
            (index) =>
        {
          'orderId': 'ORD${(1000 + index)}',
          'customerName': 'Customer $index',
          'totalAmount': '\$${(index + 1) * 200}',
          'orderDate': '2025-3-14${index + 1}',
          'status': index % 2 == 0 ? "Delivered" : "Pending",

        });
  }
}