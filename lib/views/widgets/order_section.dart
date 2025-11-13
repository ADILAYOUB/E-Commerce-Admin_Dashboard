import 'package:e_commerce_admin_dashboard_006/controllers/dashboard_controller.dart';
import 'package:e_commerce_admin_dashboard_006/controllers/order_controller.dart';
import 'package:e_commerce_admin_dashboard_006/controllers/product_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderSection extends StatefulWidget {
  const OrderSection({super.key});

  @override
  State<OrderSection> createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  final OrderController controller = Get.put(OrderController());

  bool _ascending = true;
  String _sortColumn = 'orderId';
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 21),
            _buildDashboardCards(),
            SizedBox(height: 31),
            _buildFilters(),
            SizedBox(height: 31),
            _buildDataTable(),
            SizedBox(height: 31),
            _buildPagination(),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCard(
          "Total Orders",
          "600",
          Icons.list_alt,
          Colors.blueAccent.shade700,
        ),
        _buildCard(
          "Delivered Orders",
          "350",
          Icons.check_circle,
          Colors.greenAccent.shade700,
        ),
        _buildCard(
          "Pending Orders",
          "150",
          Icons.pending,
          Colors.orangeAccent.shade700,
        ),
        _buildCard("Cancelled Orders", "60", Icons.cancel, Colors.red.shade700),
      ],
    );
  }

  Widget _buildCard(String title, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 30, color: color),
                  SizedBox(width: 9),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11),
              Text(
                val,
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.88),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1.4,
            blurRadius: 5.2,
            offset: Offset(0, 3.4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Search Orders",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.withOpacity(0.95),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("A problem occurred."));
          }
          final data = _applyFilters(snapshot.data!);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: [
                'orderId',
                'customerName',
                'totalAmount',
                'orderDate',
                'status',
              ].indexOf(_sortColumn),
              columns: [
                _buildDataColumn("Order ID", "orderId"),
                _buildDataColumn("Customer Name", "customerName"),
                _buildDataColumn("Total Amount", "totalAmount"),
                _buildDataColumn("Order Date", "orderDate"),
                _buildDataColumn("Status", "status"),
              ],
              rows: data.map((item) => _buildDataRow(item)).toList(),
            ),
          );
        },
      ),
    );
  }

  DataColumn _buildDataColumn(
    String label,
    String key, {
    bool numeric = false,
  }) {
    return DataColumn(
      label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      numeric: numeric,
      onSort: (columnIndex, ascending) {
        setState(() {
          _sortColumn = key;
          _ascending = ascending;
        });
      },
    );
  }

  DataRow _buildDataRow(Map<String, dynamic> item) {
    return DataRow(
      cells: [
        DataCell(Text(item['orderId']?.toString() ?? "N/A")),
        DataCell(Text(item['customerName']?.toString() ?? "N/A")),
        DataCell(Text(item['totalAmount']?.toString() ?? "N/A")),
        DataCell(Text(item['orderDate']?.toString() ?? "N/A")),
        DataCell(Text(item['status']?.toString() ?? "N/A")),
      ],
    );
  }

  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> data) {
    String searchText = _searchController.text.toLowerCase();

    return data.where((item) {
      if (searchText.isNotEmpty &&
          !item['customerName'].toLowerCase().contains(searchText)) {
        return false;
      }
      return true;
    }).toList();
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("1-5 of 5 customers"),
        SizedBox(width: 15),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_left),
          color: Colors.grey.shade800,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.redAccent.shade700,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text("1", style: TextStyle(color: Colors.white)),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_right),
          color: Colors.redAccent.shade700,
        ),
      ],
    );
  }
}
