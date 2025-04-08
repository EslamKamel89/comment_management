import 'package:comment_management/core/themes/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleThemeSwitch extends StatelessWidget {
  const ToggleThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return Switch(
      value: themeCubit.state.brightness == Brightness.dark,
      onChanged: (value) {
        themeCubit.toggleTheme();
      },
    );
  }
}
