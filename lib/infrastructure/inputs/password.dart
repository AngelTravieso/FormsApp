import 'package:formz/formz.dart';

enum PasswordError { empty, length }

class Password extends FormzInput<String, PasswordError> {
  // Estado inicial
  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  // getter para obtener el mensaje de error
  String? get errorMessage {
    // Si es valido el input
    if (isValid || isPure) return null;

    /// [displayError] Propiedad para mostrar el error
    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 6 caracteres';

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 6) return PasswordError.length;

    return null;
  }
}
