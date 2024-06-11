// lib/grid_notepad.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grid_model.dart';
import 'custom_keypads.dart';

class GridNotepad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gridModel = Provider.of<GridModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tabular Notepad'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  defaultColumnWidth: FixedColumnWidth(100.0),
                  children: [
                    // Column headers
                    TableRow(
                      children: List.generate(
                        gridModel.columnHeaders.length + 1,
                            (index) => index == 0
                            ? TableCell(child: Container())
                            : TableCell(
                          child: GestureDetector(
                            onLongPress: () => _showColumnOptions(context, index - 1),
                            child: Container(
                              color: Theme.of(context).primaryColor.withOpacity(0.2),
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              child: Text(
                                gridModel.columnHeaders[index - 1],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Grid cells with row headers
                    ...gridModel.grid.asMap().map((i, row) {
                      return MapEntry(
                        i,
                        TableRow(
                          children: [
                            // Row header
                            GestureDetector(
                              onLongPress: () => _showRowOptions(context, i),
                              child: Container(
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                child: Text(
                                  gridModel.rowHeaders[i],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // Cells
                            ...row.asMap().map((j, cell) {
                              FocusNode focusNode = FocusNode();
                              return MapEntry(
                                j,
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      focusNode: focusNode,
                                      keyboardType: _getKeyboardType(gridModel.columnInputTypes[j]),
                                      controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                          text: cell,
                                          selection: TextSelection.fromPosition(
                                            TextPosition(offset: cell.length),
                                          ),
                                        ),
                                      ),
                                      readOnly: gridModel.columnInputTypes[j] == InputType.oceny ||
                                          gridModel.columnInputTypes[j] == InputType.obeconsc,
                                      onTap: () {
                                        if (gridModel.columnInputTypes[j] == InputType.oceny) {
                                          _showCustomKeypad(context, OcenyKeypad(onKeyPressed: (key) {
                                            gridModel.updateCell(i, j, key);
                                            Navigator.of(context).pop();
                                            focusNode.unfocus();
                                          }));
                                        } else if (gridModel.columnInputTypes[j] == InputType.obeconsc) {
                                          _showCustomKeypad(context, ObeconscKeypad(onKeyPressed: (key) {
                                            gridModel.updateCell(i, j, key);
                                            Navigator.of(context).pop();
                                            focusNode.unfocus();
                                          }));
                                        }
                                      },
                                      onChanged: (value) {
                                        if (gridModel.columnInputTypes[j] == InputType.text ||
                                            gridModel.columnInputTypes[j] == InputType.number) {
                                          gridModel.updateCell(i, j, value);
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).values.toList(),
                          ],
                        ),
                      );
                    }).values.toList(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => gridModel.addRow(),
                child: Text('Add Row'),
              ),
              ElevatedButton(
                onPressed: () => gridModel.addColumn(),
                child: Text('Add Column'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType(InputType inputType) {
    switch (inputType) {
      case InputType.number:
        return TextInputType.number;
      case InputType.text:
      case InputType.oceny:
      case InputType.obeconsc:
      default:
        return TextInputType.text;
    }
  }

  void _showCustomKeypad(BuildContext context, Widget keypad) {
    showModalBottomSheet(
      context: context,
      builder: (context) => keypad,
    );
  }

  void _showRowOptions(BuildContext context, int rowIndex) {
    final gridModel = Provider.of<GridModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        String newName = gridModel.rowHeaders[rowIndex];
        return AlertDialog(
          title: Text('Row Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: newName),
                decoration: InputDecoration(labelText: 'Rename Row'),
                onChanged: (value) {
                  newName = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                gridModel.renameRow(rowIndex, newName);
                Navigator.of(context).pop();
              },
              child: Text('Rename'),
            ),
            TextButton(
              onPressed: () {
                gridModel.removeRow(rowIndex);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showColumnOptions(BuildContext context, int columnIndex) {
    final gridModel = Provider.of<GridModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        String newName = gridModel.columnHeaders[columnIndex];
        InputType newInputType = gridModel.columnInputTypes[columnIndex];
        return AlertDialog(
          title: Text('Column Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: newName),
                decoration: InputDecoration(labelText: 'Rename Column'),
                onChanged: (value) {
                  newName = value;
                },
              ),
              DropdownButton<InputType>(
                value: newInputType,
                onChanged: (value) {
                  newInputType = value!;
                },
                items: InputType.values.map((inputType) {
                  return DropdownMenuItem<InputType>(
                    value: inputType,
                    child: Text(inputType.toString().split('.').last),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                gridModel.renameColumn(columnIndex, newName);
                gridModel.updateColumnInputType(columnIndex, newInputType);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                gridModel.removeColumn(columnIndex);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
