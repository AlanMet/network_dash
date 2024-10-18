import 'package:flutter/material.dart';
import 'package:network_dash/helper/menu_model.dart';

class SideMenuData {
  final menu = <MenuModel>[
    const MenuModel(icon: Icon(Icons.layers, size: 32), title: 'Configuration'),
    const MenuModel(icon: Icon(Icons.settings, size: 32), title: 'Training'),
    const MenuModel(icon: Icon(Icons.show_chart, size: 32), title: 'Stats'),
    const MenuModel(icon: Icon(Icons.apps, size: 32), title: 'Models'),
    const MenuModel(icon: Icon(Icons.logout, size: 32), title: 'Log Out'),
  ];
}