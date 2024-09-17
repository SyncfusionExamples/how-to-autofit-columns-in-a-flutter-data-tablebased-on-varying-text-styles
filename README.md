# How to adjust row height dynamically based on the content of cells in a Flutter DataTable (SfDataGrid)?

Autofitting columns in a [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid) can be achieved by dynamically adjusting the column size based on varying text styles. This feature makes sure that the columns may change in size to fit the content without overlapping or being cut off.

## STEP 1:
To autofit columns in a [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid) based on varying text styles, you can create a custom class that extends the [ColumnSizer](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/ColumnSizer-class.html) class. You should override the computeHeaderCellWidth and computeCellWidth methods to calculate the width for the cell using textStyle. Likewise, you need to override the computeHeaderCellHeight and computeCellHeight methods to determine the height of the cell accordingly. It's essential to maintain a consistent textStyle to ensure columns in a [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid) are properly autofitted.

 ```dart
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

 
 ```

## STEP 2:
Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. The [SfDataGrid.onQueryRowHeight](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/onQueryRowHeight.html) property is a callback that allows you to specify the row height for each row in the data grid. The details parameter provides information about the row index and other details. The [SfDataGrid.columnSizer](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/columnSizer.html) property, which is responsible for calculating the widths and heights of the columns in the data grid.

```dart
class MyHomePageState extends State<MyHomePage> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  TextStyle headerTextStyle =
      const TextStyle(fontFamily: 'Arial', fontSize: 25, color: Colors.pink);
  @override
  void initState() {
    super.initState();
    _employees = _getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employeeData: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
          onQueryRowHeight: (details) {
            return details.getIntrinsicRowHeight(details.rowIndex);
          },
          columnWidthMode: ColumnWidthMode.auto,
          columnSizer: _customColumnSizer,
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
              child: Text('ID', style: headerTextStyle))),
      GridColumn(
          columnName: 'Name',
          label: Container(
              alignment: Alignment.center,
              child: Text('Name', style: headerTextStyle))),
      GridColumn(
          columnName: 'Designation',
          label: Container(
              alignment: Alignment.center,
              child: Text(
                'Designation',
                style: headerTextStyle,
              ))),
      GridColumn(
          columnName: 'Salary',
          label: Container(
              alignment: Alignment.center,
              child: Text('Salary', style: headerTextStyle))),
    ];
  }
} 
 ```
