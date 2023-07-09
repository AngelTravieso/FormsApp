import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    // Validando formulario
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      /*    
      Para los campos se coloca el valor que tenga en el state, de esta manera al postear el formulario se muestran los mensajes de error, basicamente le decimos a Formz, ensucia estos campos con lo que tenga en el state, este vacio o no
       */
      username: Username.dirty(state.username.value),
      password: Password.dirty(state.password.value),
      email: Email.dirty(state.email.value),
      isValid: Formz.validate([
        state.username,
        state.email,
        state.password,
      ]),
    ));

    if (kDebugMode) {
      print('Cubit Submit: $state');
    }
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
        state.email,
        state.password,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([
        email,
        state.username,
        state.password,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([
        state.username,
        state.email,
        password,
      ]),
    ));
  }
}
