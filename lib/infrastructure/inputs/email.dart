import 'package:formz/formz.dart';

// Define input validation errors
enum EmailError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmailError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Email.dirty(String value) : super.dirty(value);

  // getter para obtener el mensaje de error
  String? get errorMessage {
    // Si es valido el input
    if (isValid || isPure) return null;

    /// [displayError] Propiedad para mostrar el error
    if (displayError == EmailError.empty) return 'El campo es requerido';

    if (displayError == EmailError.format) {
      return 'No tiene formato de correo electrónico';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;

    // Si el correo no es valido
    if (!emailRegExp.hasMatch(value)) return EmailError.format;

    return null;
  }
}
