// lib/grid_model.dart
import 'package:flutter/material.dart';

class GridModel extends ChangeNotifier {
  List<String> groupNames = [];
  String currentGroup = '';
  String _passcode = '1478';

  Map<String, List<List<String>>> groupData = {};
  Map<String, List<String>> groupColumnHeaders = {};
  Map<String, List<String>> groupRowHeaders = {};
  Map<String, List<InputType>> groupColumnInputTypes = {};

  List<List<String>> grid = [];
  List<String> columnHeaders = [];
  List<String> rowHeaders = [];
  List<InputType> columnInputTypes = [];

  void setCurrentGroup(String group) {
    currentGroup = group;
    grid = groupData[group] ?? [];
    columnHeaders = groupColumnHeaders[group] ?? [];
    rowHeaders = groupRowHeaders[group] ?? [];
    columnInputTypes = groupColumnInputTypes[group] ?? [];
    notifyListeners();
  }

  void addGroup(String groupName) {
    if (!groupNames.contains(groupName)) {
      groupNames.add(groupName);
      groupData[groupName] = [];
      groupColumnHeaders[groupName] = [];
      groupRowHeaders[groupName] = [];
      groupColumnInputTypes[groupName] = [];
      setCurrentGroup(groupName);
    }
    notifyListeners();
  }

  void removeGroup(String groupName) {
    groupNames.remove(groupName);
    groupData.remove(groupName);
    groupColumnHeaders.remove(groupName);
    groupRowHeaders.remove(groupName);
    groupColumnInputTypes.remove(groupName);

    if (currentGroup == groupName && groupNames.isNotEmpty) {
      setCurrentGroup(groupNames.first);
    } else if (groupNames.isEmpty) {
      currentGroup = '';
      grid = [];
      columnHeaders = [];
      rowHeaders = [];
      columnInputTypes = [];
    }
    notifyListeners();
  }

  void addRow() {
    if (currentGroup.isNotEmpty) {
      List<String> newRow = List.generate(columnHeaders.length, (index) => '');
      groupData[currentGroup]!.add(newRow);
      groupRowHeaders[currentGroup]!.add('Row ${groupRowHeaders[currentGroup]!.length + 1}');
      notifyListeners();
    }
  }

  void addColumn() {
    if (currentGroup.isNotEmpty) {
      for (var row in groupData[currentGroup]!) {
        row.add('');
      }
      groupColumnHeaders[currentGroup]!.add('Column ${groupColumnHeaders[currentGroup]!.length + 1}');
      groupColumnInputTypes[currentGroup]!.add(InputType.text);
      notifyListeners();
    }
  }

  void removeRow(int index) {
    if (currentGroup.isNotEmpty) {
      groupData[currentGroup]!.removeAt(index);
      groupRowHeaders[currentGroup]!.removeAt(index);
      notifyListeners();
    }
  }

  void removeColumn(int index) {
    if (currentGroup.isNotEmpty) {
      for (var row in groupData[currentGroup]!) {
        row.removeAt(index);
      }
      groupColumnHeaders[currentGroup]!.removeAt(index);
      groupColumnInputTypes[currentGroup]!.removeAt(index);
      notifyListeners();
    }
  }

  void updateCell(int rowIndex, int colIndex, String value) {
    if (currentGroup.isNotEmpty) {
      groupData[currentGroup]![rowIndex][colIndex] = value;
      notifyListeners();
    }
  }

  void renameRow(int index, String newName) {
    if (currentGroup.isNotEmpty) {
      groupRowHeaders[currentGroup]![index] = newName;
      notifyListeners();
    }
  }

  void renameColumn(int index, String newName) {
    if (currentGroup.isNotEmpty) {
      groupColumnHeaders[currentGroup]![index] = newName;
      notifyListeners();
    }
  }

  void updateColumnInputType(int index, InputType inputType) {
    if (currentGroup.isNotEmpty) {
      groupColumnInputTypes[currentGroup]![index] = inputType;
      notifyListeners();
    }
  }

  void setPasscode(String passcode) {
    _passcode = passcode;
    notifyListeners();
  }

  bool verifyPasscode(String passcode) {
    return _passcode == passcode;
  }
}

enum InputType { text, number, oceny, obeconsc }
