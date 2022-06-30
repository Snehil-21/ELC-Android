import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/catalog.dart';

class Details extends StatelessWidget {
  final Item item;
  const Details({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        buttonPadding: EdgeInsets.zero,
        children: [
          '\$${item.price}'.text.italic.bold.xl4.make().py2(),
          ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent,
                      shape: const StadiumBorder()),
                  onPressed: () {
                    print('Hello Object');
                  },
                  child: "Buy".text.make())
              .wh(100, 50)
        ],
      ).p16(),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(tag: Key(item.id.toString()), child: Image.network(item.image))
                .h32(context),
            Expanded(
              child: VxArc(
                height: 30,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  width: context.screenWidth,
                  color: Colors.white,
                  child: Column(
                    children: [
                      item.name.text.xl5.bold.make().py2(),
                      item.desc.text.xl.make().py2(),
                    ],
                  ).py64(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
