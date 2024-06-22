import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text('melodIQ',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
