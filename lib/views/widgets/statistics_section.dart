import 'package:e_commerce_admin_dashboard_006/controllers/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatisticsSection extends StatefulWidget {
  const StatisticsSection({super.key});

  @override
  State<StatisticsSection> createState() => _StatisticsSectionState();
}

class _StatisticsSectionState extends State<StatisticsSection> {
  final DashboardController controller = Get.put(DashboardController());

  bool _ascending = true;
  String _sortColumn = 'sales';
  String _filterCategory = 'All';
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
              "Dashboard Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 21),
            _buildDashboardCards(),
            SizedBox(height: 31),
            _buildChartRow(),
            SizedBox(height: 31),
            _buildFilters(),
            SizedBox(height: 31),
            _buildDataTable(),
            SizedBox(height: 31),
            _buildPagination(),

            SizedBox(height: 100,)
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
          "Total Revenue",
          "\$35.000",
          Icons.attach_money,
          Colors.purpleAccent,
        ),
        _buildCard(
          "Avg Order Value",
          "\$120",
          Icons.bar_chart,
          Colors.greenAccent,
        ),
        _buildCard(
          "Total Customers",
          "1800",
          Icons.attach_money,
          Colors.blueAccent,
        ),
        _buildCard(
          "Total Products",
          "800",
          Icons.inventory,
          Colors.orangeAccent,
        ),
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

  Widget _buildChartRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 350, child: _buildLineChart()),
        SizedBox(width: 350, child: _buildBarChart()),
        SizedBox(width: 350, child: _buildPieChart()),
      ],
    );
  }

  Widget _buildLineChart() {
    return _buildChartContainer(
      title: "Sales Trend",
      chart: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget:
                    (value, meta) => Text(
                      ['Jan', 'Feb', 'Mar', 'Apr', 'May'][value.toInt()],
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget:
                    (value, meta) => Text(
                      '${value.toInt()}K',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 2),
                FlSpot(2, 3),
                FlSpot(3, 3),
                FlSpot(4, 4),
              ],
              isCurved: true,
              color: Colors.blueAccent,
              barWidth: 3,
              isStrokeCapRound: true,
              // dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.15),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (List<LineBarSpot> touchedBarSports) {
                return touchedBarSports.map((barSpot) {
                  final flSpot = barSpot;
                  return LineTooltipItem(
                    '${flSpot.y}K',
                    TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return _buildChartContainer(
      title: "Category Sales",
      chart: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, red, redIndex) {
                return BarTooltipItem(
                  red.toY.round().toString(),
                  TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const titles = ['A', 'B', 'C', 'D'];
                  return Text(
                    titles[value.toInt()],
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 30,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}K',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [BarChartRodData(toY: 10, color: Colors.blueAccent)],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [BarChartRodData(toY: 15, color: Colors.blueAccent)],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [BarChartRodData(toY: 5, color: Colors.blueAccent)],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [BarChartRodData(toY: 20, color: Colors.blueAccent)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return _buildChartContainer(
      title: "Revenue Distribution",

      chart: PieChart(
        PieChartData(
          centerSpaceRadius: 55,
          sectionsSpace: 0,
          sections: [
            PieChartSectionData(
              value: 50,
              color: Colors.blueAccent,
              title: '50%',
              titleStyle: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 15,
              color: Colors.orangeAccent,
              title: '15%',
              titleStyle: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 25,
              color: Colors.purpleAccent,
              title: '25%',
              titleStyle: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 10,
              color: Colors.redAccent,
              title: '10%',
              titleStyle: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartContainer({required String title, required Widget chart}) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.2, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 17),
          SizedBox(height: 200, child: chart),
        ],
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
                hintText: "Search Product",
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
          SizedBox(width: 15.8),
          DropdownButton<String>(
            value: _filterCategory,
            underline: Container(),
            icon: Icon(Icons.filter_list),
            style: TextStyle(
              color: Colors.black87.withOpacity(0.95),
              fontSize: 16.4,
            ),
            onChanged: (value) => setState(() {}),
            items:
                [
                      "All",
                      "Category 0",
                      "Category 1",
                      "Category 2",
                      "Category 3",
                      "Category 4",
                    ]
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
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
                'productName',
                'category',
                'sales',
                'stock',
                'totalRevenue',
                'averageOrderValue',
                'dataAdded',
              ].indexOf(_sortColumn),
              columns: [
                _buildDataColumn("Product Name", "productName"),
                _buildDataColumn("Category", "category"),
                _buildDataColumn("Sales", "sales", numeric: true),
                _buildDataColumn("Stock", "stock", numeric: true),
                _buildDataColumn(
                  "Total Revenue",
                  "totalRevenue",
                  numeric: true,
                ),
                _buildDataColumn(
                  "Avg Order Value",
                  "averageOrderValue",
                  numeric: true,
                ),

                _buildDataColumn("Date Added", "dataAdded"),
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
    String formatNumber(dynamic value) {
      if (value == null) return "N/A";
      if (value is num) {
        return NumberFormat('#,###.00').format(value);
      }
      return value.toString();
    }

    String formatCurrency(dynamic value) {
      if (value == null) return "N/A";
      if (value == null) {
        return '\$${NumberFormat('#,###.00').format(value)}';
      }
      return value.toString();
    }
    String formatDate(dynamic value) {
      if (value == null) return "N/A";
      try{
        return DateFormat('MMM d, yyyy').format(DateTime.parse(value.toString()));
      }catch (e){
        return value.toString();
      }
    }
    return DataRow(cells: [
      DataCell(Text(item['productName']?.toString() ?? "N/A")),
      DataCell(Text(item['category']?.toString() ?? "N/A")),
      DataCell(Text(formatNumber(item['sales']))),
      DataCell(Text(formatNumber(item['stock']))),
      DataCell(Text(formatCurrency(item['totalRevenue']))),
      DataCell(Text(formatCurrency(item['averageOrderValue']))),
      DataCell(Text(formatDate(item['dataAdded']))),

    ]);
  }

  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> data) {
    String searchText = _searchController.text.toLowerCase();

    var filterData =
        data.where((item) {
          if (_filterCategory != 'All' && item['category'] != _filterCategory) {
            return false;
          }
          if (searchText.isNotEmpty &&
              !item['productName'].toLowerCase().contains(searchText)) {
            return false;
          }
          return true;
        }).toList();

    filterData.sort((a, b) {
      var aValue = a[_sortColumn];
      var bValue = b[_sortColumn];
      if (aValue is String && bValue is String) {
        return _ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      } else if (aValue is num && bValue is num) {
        return _ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      }
      return 0;
    });
    return filterData;
  }

  Widget _buildPagination(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("1-10 of 50 items"),
        SizedBox(width: 15,),
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.chevron_left),
            color: Colors.grey.shade800,

        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.redAccent.shade700,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Text("1",style: TextStyle(
            color: Colors.white
          ),),
        ),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.chevron_right),
          color: Colors.redAccent.shade700,

        )
      ],
    );
  }
}
