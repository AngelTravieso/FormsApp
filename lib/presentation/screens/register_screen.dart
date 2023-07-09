import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nuevo usuario',
        ),
      ),
      body: BlocProvider(
        create: (_) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: FlutterLogo(size: 100),
              ),
              _RegisterForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            // onChanged: (val) => registerCubir.usernameChanged,
            onChanged: (val) {
              registerCubit.usernameChanged(val);
              _formKey.currentState?.validate();
            },
            validator: (val) {
              if (val == null || val.isEmpty) return 'Campo requerido';
              if (val.trim().isEmpty) return 'Campo requerido';
              if (val.trim().length < 6) return 'Más de 6 letras';
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (val) {
              registerCubit.emailChanged(val);
              _formKey.currentState?.validate();
            },
            validator: (val) {
              if (val == null || val.isEmpty) return 'Campo requerido';
              if (val.trim().isEmpty) return 'Campo requerido';

              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );

              if (!emailRegExp.hasMatch(val)) {
                return 'No tiene formato de correo';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (val) {
              registerCubit.passwordChanged(val);
              _formKey.currentState?.validate();
            },
            validator: (val) {
              if (val == null || val.isEmpty) return 'Campo requerido';
              if (val.trim().isEmpty) return 'Campo requerido';
              if (val.trim().length < 6) return 'Más de 6 letras';
              return null;
            },
          ),
          const SizedBox(height: 10),
          FilledButton.tonalIcon(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) return;

              registerCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
          ),
        ],
      ),
    );
  }
}
