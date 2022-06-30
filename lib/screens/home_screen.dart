import 'package:first_app/models/cart.dart';
import 'package:first_app/models/catalog.dart';
import 'package:first_app/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../core/store.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var catalogJson = await rootBundle.loadString("assets/files/catalog.json");

    // var response = await http.get(Uri.parse(url));
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    // var catalogJson = response.body;
    var decodedData = jsonDecode(catalogJson);
    var productsData = decodedData['products'];
    // print(productsData);
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      floatingActionButton: VxBuilder(
        mutations: const {AddMutation, RemoveMutation},
        builder: (context, _, __) => FloatingActionButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/cart');
            context.vxNav.push(Uri.parse('/cart'));
          },
          backgroundColor: Colors.deepPurpleAccent,
          child: const Icon(Icons.shopping_cart),
        ).badge(size: 24, color: Vx.red400, count: _cart.items.length),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: CatalogModel.items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CatalogHeader(),
                    const CatalogList().py16().expand(),
                  ],
                ),
        ),
      ),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.make(),
        "Trending Products".text.xl2.make(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
          onTap: () => context.vxNav.push(
              Uri(
                path: '/details',
                queryParameters: {"id": catalog.id.toString()},
              ),
              params: catalog),
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Details(item: catalog),
          //   ),
          // ),
          child: CatalogItem(catalog: catalog),
        );
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  const CatalogItem({Key? key, required this.catalog}) : super(key: key);

  final Color myColor = const Color(0xfff4f4f4);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: Image.network(catalog.image)
                .box
                .p20
                .rounded
                .color(Colors.white70)
                .make()
                .p12()
                .w40(context),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                catalog.name.text.xl3.bold.make().py2(),
                catalog.desc.text.make().py2(),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  buttonPadding: EdgeInsets.zero,
                  children: [
                    '\$${catalog.price}'.text.italic.bold.xl2.make().py2(),
                    _AddToCart(catalog: catalog),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).square(200).color(myColor).rounded.p4.make().p4();
  }
}

class _AddToCart extends StatelessWidget {
  final Item catalog;
  const _AddToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;

    bool isAdded = _cart.items.contains(catalog) ? true : false;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.indigoAccent, shape: const StadiumBorder()),
      onPressed: () {
        if (!isAdded) {
          AddMutation(catalog);
        }
      },
      child: isAdded
          ? const Icon(Icons.done)
          : const Icon(Icons.shopping_bag_outlined),
    );
  }
}

// experimental code for containers within container

// Container(
//             color: Colors.green,
//             height: 250,
//             width: 250,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     color: Colors.red,
//                     height: 100,
//                     width: 100,
//                   ),
//                   Container(
//                     color: Colors.yellow,
//                     height: 100,
//                     width: 100,
//                   ),
//                   Container(
//                     color: Colors.blue,
//                     height: 100,
//                     width: 100,
//                   ),
//                 ],
//               ),
//             ),
//           )
