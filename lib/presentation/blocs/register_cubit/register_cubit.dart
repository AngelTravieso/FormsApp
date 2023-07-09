import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    print('Cubit Submit: $state');
  }

  void usernameChanged(String value) {
    // Instancia con el valor que se este mandando del input
    final username = Username.dirty(value);

    emit(state.copyWith(
      username: username,
      //  Valida el campo con las reglas indicadas en el validator del campo
      isValid: Formz.validate([
        username,
        // Se mandan las otras instancias de los inputs, ya que la funcion necesita validad cada uno de los campos para verificar si el formulario es valido
        state.password,
      ]),
    ));
  }

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([
        state.username,
        password,
      ]),
    ));
  }
}
