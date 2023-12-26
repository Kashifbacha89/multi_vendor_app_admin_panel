import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/categories_screen.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/orders_screen.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/products_screen.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/upload_banners_screen.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/vendor_screen.dart';
import 'package:multi_vendor_app_admin_panel/views/screens/side_bar_screens/widthdrwal_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem=DashboardScreen();
  screenSelector(item){
    switch(item.route){
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem=DashboardScreen();
        });
        break;
      case VendorScreen.routeName:
        setState(() {
          _selectedItem=VendorScreen();
        });
        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem=WithdrawalScreen();
        });
        break;
      case OrdersScreen.routeName:
        setState(() {
          _selectedItem=OrdersScreen();
        });
        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem=CategoriesScreen();
        });
        break;
      case ProductsScreen.routeName:
        setState(() {
          _selectedItem=ProductsScreen();
        });
        break;
      case UploadBannersScreen.routeName:
        setState(() {
          _selectedItem=UploadBannersScreen();
        });
        break;

    }
  }
  @override
  Widget build(BuildContext context) {
    return  AdminScaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          title: Text('Management'),
        ),
        sideBar: SideBar(items: [
          AdminMenuItem(title: 'Dashboard',icon: Icons.dashboard,route: DashboardScreen.routeName),
          AdminMenuItem(title: 'Vendors',icon: CupertinoIcons.person_3,route: VendorScreen.routeName),
          AdminMenuItem(title: 'Withdrawal',icon: CupertinoIcons.money_dollar,route: WithdrawalScreen.routeName),
          AdminMenuItem(title: 'Orders',icon: CupertinoIcons.shopping_cart,route: OrdersScreen.routeName),
          AdminMenuItem(title: 'Categories',icon: Icons.category,route: CategoriesScreen.routeName),
          AdminMenuItem(title: 'Products',icon: Icons.shop,route: ProductsScreen.routeName),
          AdminMenuItem(title: 'Upload Banners',icon: CupertinoIcons.add,route: UploadBannersScreen.routeName),
        ], selectedRoute: '',
        onSelected: (item){
          screenSelector(item);
        },
          header:Container(
            height:50,
            width:double.infinity,
            color:Color(0xFF444444),
          child:Center(
            child:Text('Bacha Store Panel',style:TextStyle(
                color:Colors.white
            )),

          )

          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: Color(0xFF444444),
            child: Center(
              child: Text('Footer',style: TextStyle(color: Colors.white),),
            ),
          ),

        ),

        body: _selectedItem);
  }
}
