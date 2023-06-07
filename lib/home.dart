import 'package:flutter/material.dart';
import 'package:posprintertest/print.dart';

class Home extends StatelessWidget {

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Produk 1',
      'price': 10000,
      'qty': 2,
      'total_price': 20000,
    },
    {
      'title': 'Produk 2',
      'price': 20000,
      'qty': 2,
      'total_price': 40000,
    },
    {
      'title': 'Produk 3',
      'price': 15000,
      'qty': 1,
      'total_price': 15000,
    },
  ];

  @override
  Widget build(BuildContext context) {

    int _total = 0;

    for (var i = 0; i < data.length; i++) {
      _total += data[i]["total_price"] as int;
    }

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (c, i) {
              return ListTile(
                title: Text(data[i]['title']),
                subtitle: Text('Rp ${data[i]["price"]} x ${data[i]["qty"]}'),
                trailing: Text('Rp ${data[i]["total_price"]}'),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  Text('Total :',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Rp $_total :',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: ElevatedButton(
                    child: const Text("total"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Print(data)));
                    },
                  )
              )
            ],
          ),
        ),
      ],
    ));
  }
}
