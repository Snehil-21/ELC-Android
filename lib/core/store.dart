import 'package:first_app/models/cart.dart';
import 'package:first_app/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  late CatalogModel catalog;
  late CartModel cart;

  MyStore() {
    cart = CartModel();
    catalog = CatalogModel();

    cart.catalog = catalog;
  }
}
