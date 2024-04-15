import 'package:flutter/material.dart';

class LanguageSelectorBottomSheet extends StatefulWidget {
  @override
  State<LanguageSelectorBottomSheet> createState() =>
      _LanguageSelectorBottomSheetState();
}

class _LanguageSelectorBottomSheetState
    extends State<LanguageSelectorBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: getSelectedItem("English"),
          ),
          InkWell(
            onTap: () {},
            child: getUnSelectedItem("Arabic"),
          )
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          ),
          Spacer(),
          Icon(Icons.check_box, size: 30, color: Theme.of(context).primaryColor)
        ],
      ),
    );
  }

  Widget getUnSelectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
