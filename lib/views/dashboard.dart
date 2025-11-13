import 'package:e_commerce_admin_dashboard_006/views/widgets/customer_section.dart';
import 'package:e_commerce_admin_dashboard_006/views/widgets/invertory_section.dart';
import 'package:e_commerce_admin_dashboard_006/views/widgets/order_section.dart';
import 'package:e_commerce_admin_dashboard_006/views/widgets/product_section.dart';
import 'package:e_commerce_admin_dashboard_006/views/widgets/sales_section.dart';
import 'package:e_commerce_admin_dashboard_006/views/widgets/statistics_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class Dashboard extends StatelessWidget {
  final DashboardController controller = Get.find();
  final yourScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Scrollbar(
              thickness: 10,
              controller: yourScrollController,

              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  children: [
                    Obx(
                          () => AnimatedContainer(
                        width: controller.sidebarOpen.value ? 210 : 70,
                        color: Color(0xffd31f3f),
                        duration: Duration(milliseconds: 300),
                        child: _buildSideBar(),
                      ),
                    ),
                    Container(
                      width: 1200,
                      color: Colors.white,
                      child: Column(
                        children: [
                          _buildHeader(),
                          Expanded(child: _buildContext()),
                        ],
                      ),
                    ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSideBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.sidebarOpen.value) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Main Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
        Obx(
          () => Column(
            children: List.generate(
              controller.sections.length,
              (index) => _buildSidebarItem(
                controller.sections[index].icon,
                controller.sections[index].title,
                index,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    return Obx(() {
      final isSelected = controller.currentSectionIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeSection(index),
        child: Container(
          color: Color(0xffd31f3f),
          padding: EdgeInsets.symmetric(vertical: 10.5),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Color(0xffd31f3f),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.5),
                      bottomLeft: Radius.circular(24.5),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 21),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 21,
                        color: isSelected ? Color(0xffb72c1c) : Colors.white,
                      ),
                      SizedBox(width: 5,),
                      if (controller.sidebarOpen.value)
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              color:
                                  isSelected ? Color(0xffb72c1c) : Colors.white,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }); // Obx
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller.toggleSidebar(),
            child: Icon(Icons.menu),
          ),
          SizedBox(width: 10),
          Text(
            "Welcome Back, dear programmer!",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.logout, color: Color(0xffb72c1c), size: 30),
        ],
      ),
    );
  }

  Widget _buildContext() {
    return Obx(() {
      switch (controller.currentSectionIndex.value) {
        case 0:
          return StatisticsSection();
        case 1:
          return ProductSection();
        case 2:
          return OrderSection();
        case 3:
          return CustomersSection();
        case 4:
          return InventorySection();
        case 5:
          return SalesSection();
        default:
          return Center(child: Text("Section Not Found"));
      }
    });
  }
}

class OrdersSection {}
