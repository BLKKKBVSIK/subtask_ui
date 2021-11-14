import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:subtask_ui/subtasks.dart';

class SubTasksViewModel extends BaseViewModel {
  /// List of widget displayed on top of the [_mainElement].
  final List<SubtaskWrapper> _topTree = [];
  List<SubtaskWrapper> get topTree => _topTree;

  /// List of the sizes of all widgets contained in [_topTree].
  final List<Size> _topSizeList = [];
  List<Size> get topSizeList => _topSizeList;

  /// List of widget displayed at the bottom of the [_mainElement].
  final List<SubtaskWrapper> _bottomTree = [];
  List<SubtaskWrapper> get bottomTree => _bottomTree;

  /// List of the sizes of all widgets contained in [_bottomTree].
  final List<Size> _bottomSizeList = [];
  List<Size> get bottomSizeList => _bottomSizeList;

  /// Main element wrapped in a [SubtaskWrapper] to obtain its [Size].
  late SubtaskWrapper _mainElement;
  SubtaskWrapper get mainElement => _mainElement;

  /// Size of the main element.
  Size _mainElementSize = const Size(0, 0);
  Size get mainElementSize => _mainElementSize;

  /// Wrap all the widgets provided by the users in [SubtaskWrapper] to obtain their [Size].
  initialize({
    List<Widget>? topChildren = const [],
    List<Widget>? bottomChildren = const [],
    required Widget mainElement,
  }) {
    _mainElement = SubtaskWrapper(
        model: this,
        onChange: (Size size, SubTasksViewModel model) {
          model.setMainElementSize(size);
        },
        child: mainElement);

    if (topChildren != null && topChildren.isNotEmpty) {
      for (var item in topChildren) {
        _topTree.add(
          SubtaskWrapper(
            model: this,
            onChange: (Size size, SubTasksViewModel model) {
              model.addToTopSizeList(size);
            },
            child: item,
          ),
        );
      }
    }
    if (bottomChildren != null && bottomChildren.isNotEmpty) {
      for (var item in bottomChildren) {
        _bottomTree.add(
          SubtaskWrapper(
            model: this,
            onChange: (Size size, SubTasksViewModel model) {
              model.addToBottomSizeList(size);
            },
            child: item,
          ),
        );
      }
    }
    notifyListeners();
  }

  void addToTopSizeList(Size size) {
    _topSizeList.add(size);
    notifyListeners();
  }

  void addToBottomSizeList(Size size) {
    _bottomSizeList.add(size);
    notifyListeners();
  }

  void setMainElementSize(Size size) {
    _mainElementSize = size;
    notifyListeners();
  }
}
