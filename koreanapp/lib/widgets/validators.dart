class FormValidators {
  FormValidators._();
  static String? requiredText(
    String? value, {
    String message = 'This field is required.',
  }) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? phonenumber(
    String? value, {
    String message = 'This field is required.',
  }) {
    if (value == null || value.trim().isEmpty) return message;

    // if (value.length < 10) return "Phone number must be of 10 digits.";

    if (int.tryParse(value) == null) return "Please enter a valid number.";
    return null;
  }

  static String? email(
    String? value, {
    String message = 'Please provide a valid email.',
  }) {
    if (value == null || value.trim().isEmpty) return 'Email is required.';
    if (!RegExp(Validators.patternEmail).hasMatch(value)) return message;
    return null;
  }

  static String? username(
    String? value, {
    String message = 'Format not matched',
  }) {
    if (value == null || value.trim().isEmpty) return 'Username is required.';
    // if (value.length < 6) return "Username must be of at least length 6.";
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Username must not have any symbol";
    }
    return null;
  }

  static String? password(
    String? value, {
    String message = 'Password is required.',
    String? dummy,
  }) {
    if (value == null || value.trim().isEmpty) return message;
    if (value.length < 8) return "Password must be of at least length 8.";

    // if (!value.contains(RegExp(r"[a-z]")) ||
    //     !value.contains(RegExp(r"[A-Z]")) ||
    //     !value.contains(RegExp(r"[0-9]")) ||
    //     !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return "Password must have A-Z, a-Z. 0-9 and symbol.";
    // }
    if (dummy == null) return null;
    if (value != dummy) return "Password doesn't match";

    return null;
  }
}

class Validators {
  // static const patternUsername = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).+';
  // static const password =
  //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#$%^&*(),.?":{}|<>])';

  static const patternEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
