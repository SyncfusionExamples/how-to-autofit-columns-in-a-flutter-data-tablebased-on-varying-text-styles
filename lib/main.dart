import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;
  late CustomColumnSizer _customColumnSizer;
  TextStyle headerTextStyle =
      const TextStyle(fontFamily: 'Arial', fontSize: 25, color: Colors.pink);
  @override
  void initState() {
    super.initState();
    _employees = _getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employeeData: _employees);
    _customColumnSizer = CustomColumnSizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
          onQueryRowHeight: (RowHeightDetails details) {
            return details.getIntrinsicRowHeight(details.rowIndex);
          },
          columnWidthMode: ColumnWidthMode.auto,
          columnSizer: _customColumnSizer,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          source: _employeeDataSource,
          columns: getColumns),
    );
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'ID',
          label: Container(
              alignment: Alignment.center,
              child: Text(
                'ID',
                style: headerTextStyle,
                softWrap: true,
              ))),
      GridColumn(
          columnName: 'Name',
          label: Container(
              alignment: Alignment.center,
              child: Text(
                'Name',
                style: headerTextStyle,
                softWrap: true,
              ))),
      GridColumn(
          columnName: 'Designation',
          label: Container(
              alignment: Alignment.center,
              child: Text(
                'Designation',
                style: headerTextStyle,
                softWrap: true,
              ))),
      GridColumn(
          columnName: 'Salary',
          label: Container(
              alignment: Alignment.center,
              child: Text(
                'Salary',
                style: headerTextStyle,
                softWrap: true,
              ))),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employeeData}) {
    datagridRows = employeeData
        .map<DataGridRow>((Employee e) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(
                  columnName: 'Designation', value: e.designation),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
            ]))
        .toList();
  }
  List<DataGridRow> datagridRows = <DataGridRow>[];
  @override
  List<DataGridRow> get rows => datagridRows;
  TextStyle rowTextStyle = const TextStyle(fontFamily: 'Arial', fontSize: 25);
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell dataGridCell) {
      return Container(
        alignment: Alignment.center,
        child: Text(dataGridCell.value.toString(), style: rowTextStyle),
      );
    }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  TextStyle rowTextStyle = const TextStyle(fontFamily: 'Arial', fontSize: 25);
  TextStyle headerTextStyle =
      const TextStyle(fontFamily: 'Arial', fontSize: 25, color: Colors.pink);

  @override
  double computeHeaderCellWidth(GridColumn column, TextStyle style) {
    return super.computeHeaderCellWidth(column, headerTextStyle);
  }

  @override
  double computeHeaderCellHeight(GridColumn column, TextStyle textStyle) {
    return super.computeHeaderCellHeight(column, headerTextStyle);
  }

  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    return super.computeCellWidth(column, row, cellValue, rowTextStyle);
  }

  @override
  double computeCellHeight(GridColumn column, DataGridRow row,
      Object? cellValue, TextStyle textStyle) {
    return super.computeCellHeight(column, row, cellValue, rowTextStyle);
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

List<Employee> _getEmployeeData() {
  return <Employee>[
    Employee(10001, 'Jack', 'Manager', 98000),
    Employee(10002, 'John', 'Project Lead', 74000),
    Employee(10003, 'Kathryn', 'Project Lead', 73500),
    Employee(10004, 'Michael', 'Developer', 45000),
    Employee(10005, 'Martin', 'Developer', 41000),
    Employee(10006, 'Lara', 'Developer', 40000),
    Employee(10007, 'Balnc', 'UI Designer', 33500),
    Employee(10008, 'Lara', 'Developer', 38000),
    Employee(10009, 'James', 'Developer', 37000),
    Employee(10010, 'Keefe', 'Developer', 35000),
  ];
}
