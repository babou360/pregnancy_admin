import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomIconButton.dart';
import 'package:mama_k_app_admin/CustomWIdgets/CustomText.dart';
import 'package:mama_k_app_admin/Screens/mothersDev/CustomTabView.dart';
import 'package:mama_k_app_admin/app/sizeConfig.dart';

class MothersDev extends StatefulWidget {
  @override
  _MothersDevState createState() => _MothersDevState();
}

class _MothersDevState extends State<MothersDev>
    with SingleTickerProviderStateMixin {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: blockHeight * 5,
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomIconButton(
                            icon: Icons.arrow_back,
                            callback: () {
                              Navigator.pop(context);
                            }),
                        Container(
                          child: CustomText(
                            text: "Mother's development ",
                            size: blockWidth * 5.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: blockHeight * 2),
                    Container(
                      height: blockHeight * 6,
                      width: double.infinity,
                      child: TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.green,
                        indicatorColor: Colors.green,
                        indicatorWeight: blockWidth * 1,
                        controller: _tabController,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: blockHeight * 8),
                        tabs: [
                          Tab(
                            child: CustomText(
                              text: "Weekly",
                              size: blockWidth * 5,
                              weight: FontWeight.w400,
                            ),
                          ),
                          Tab(
                            child: CustomText(
                              text: "Monthly",
                              size: blockWidth * 5,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20.0),
                  ],
                ),
                Container(
                  height: blockHeight * 80,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      CustomTabView(type: "weekly"),
                      CustomTabView(type: "monthly"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
