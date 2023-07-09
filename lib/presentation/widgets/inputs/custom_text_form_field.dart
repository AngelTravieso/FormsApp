import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      // borderSide: BorderSide(
      //   color: colors.primary,
      // ),
    );

    return TextFormField(
      onChanged: (val) {
        print('value: $val');
      },
      validator: (val) {
        if (val == null) return 'Campo requerido';
        if (val.isEmpty) return 'Campo requerido';
        if (val.trim().isEmpty) return 'Campo requerido';

        return null;
      },
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
      ),
    );
  }
}
