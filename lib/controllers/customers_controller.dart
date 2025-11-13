import 'package:get/get.dart';


class CustomersController extends GetxController {

  // getting and creating dummy data, you can use api or database
  Future<List<Map<String, dynamic>>> fetchData() async {
    return List.generate(
        5,
            (index) =>
        {
          'customersId': 'CUS${(index + 1000)}',
          'customersName': 'Customer $index',
          'email': 'customer$index@example.com',
          'totalOrders': '${(index + 1) * 5} orders',
          'status': index % 2 == 0 ? "Active" : "Inactive",

        });
  }
}