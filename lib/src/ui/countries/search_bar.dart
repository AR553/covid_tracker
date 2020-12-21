import 'package:flutter/material.dart';
import 'package:zero_to_hero/src/blocs/search_input_bloc.dart';

import '../dimens.dart';
import '../my_colors.dart';
import '../strings.dart';

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  SearchBar({@required this.searchInputBloc});
  final SearchInputBloc searchInputBloc;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _txtController = TextEditingController();
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).backgroundColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimens.RADIUS_L,
        ),
        color: MyColors.CURVED_TAB_BAR_BG,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: Dimens.INSET_S,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: Dimens.INSET_S,
              ),
              child: _getSearchIcon(context),
            ),
            Expanded(
              child: TextFormField(
                controller: _txtController,
                cursorColor: color,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Strings.SEARCH,
                  hintStyle: TextStyle(
                    color: color,
                  ),
                ),
                style: TextStyle(
                  color: color,
                ),
                onChanged: _onInputChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onInputChanged(String input) {
    _active = input.isNotEmpty;
    widget.searchInputBloc.updateSearchInput(input);
  }

  Widget _getSearchIcon(BuildContext context) {
    final Color color = Theme.of(context).backgroundColor;
    if (_active) {
      return IconButton(
        icon: Icon(
          Icons.clear,
          color: color,
        ),
        onPressed: () {
          _txtController.clear();
          // make active false so icon changes when text is cleared
          _active = false;
          widget.searchInputBloc.updateSearchInput("");
        },
      );
    }
    // returning IconButton instead of Icon for consistent UI style
    return IconButton(
      icon: Icon(
        Icons.search,
        color: color,
      ),
      onPressed: null,
    );
  }
}
