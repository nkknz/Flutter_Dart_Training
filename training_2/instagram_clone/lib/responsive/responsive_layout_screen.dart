import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    super.key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    //listen: false makes it listen only one time
    //call refreshUser() once
    // ignore: no_leading_underscores_for_local_identifiers
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    //LayoutBuilder() helps creating responsive layout
    //and returns context and constraints
    return user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        // : _file == null
        //     ? const Center(
        //         child: Text("File is null"),
        //       )
        : LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > webScreenSize) {
                return widget.webScreenLayout;
              }
              return widget.mobileScreenLayout;
            },
          );
  }
}
