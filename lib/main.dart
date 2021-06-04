
import 'package:bdti/pages/costumer_list/costumer_list_page.dart';
import 'package:bdti/pages/form_costumer/formulario.dart';

import 'package:bdti/utils/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/costumer_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<CostumerController>(
      create: (_) => CostumerController(),
    ),
  ], child: BdtiApp()));
}

class BdtiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer BDTI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CostumerList(),
      initialRoute: AppRoutes.COSTUMER_LIST,
      routes: {
       
        AppRoutes.COSTUMER_LIST: (context) => CostumerList(),
        AppRoutes.COSTUMER_FORMULARIO: (context) => FormularioPage(),
      },
    );
  }
}
