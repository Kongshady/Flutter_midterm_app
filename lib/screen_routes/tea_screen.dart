import 'package:flutter/material.dart';
import 'package:health_app/widgets/tabs/adult_tab.dart';
import 'package:health_app/widgets/tabs/child_tab.dart';
import 'package:health_app/widgets/tabs/infant_tab.dart';

class TEAScreen extends StatelessWidget {
  const TEAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Total Energy Allowance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.green,
            centerTitle: true,
          ),
          body: const Column(
            children: [
              TabBar(
                labelColor: Colors.green,
                indicatorColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  // First Tab Icon holder
                  Tab(
                    icon: Icon(Icons.baby_changing_station),
                  ),

                  // Second Tab Icon holder
                  Tab(
                    icon: Icon(Icons.child_care),
                  ),

                  // Third Tab Icon holder
                  Tab(
                    icon: Icon(Icons.person_rounded),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  // First Tab
                  InfantTab(),

                  // Second Tab
                  ChildTab(),

                  // Third Tab
                  AdultTab(),
                ]),
              )
            ],
          )),
    );
  }
}
