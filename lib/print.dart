import 'package:flutter/material.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class Print extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  Print(this.data);

  @override
  _PrintState createState() => _PrintState();
}

class _PrintState extends State<Print> {

  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _devicesMsg = '';

  @override
  void initState() {
    initPrinter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
      ),
      body: _devices.isEmpty ? Center(child: Text(_devicesMsg ?? ''),) :

      ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (c, i) {
            return ListTile(
              leading: Icon(Icons.print),
              title: Text(_devices[i].name as String),
              subtitle: Text(_devices[i].address as String),
              onTap: (){
                _startPrint(_devices[i]);
              },
            );
          }
      )
      ,
    );
  }

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      print(_devices);
      if (_devices.isEmpty)
        setState(() => _devicesMsg = ' No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {

    _printerManager.selectPrinter(printer);
    final result = await _printerManager.printTicket((await _ticket()) as List<int>);
    print(result);
  }

  Future<Generator> _ticket() async {
    final List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final ticket = Generator(PaperSize.mm80, profile);

    ticket.text('test');

    ticket.cut();
    return ticket;
  }
}
