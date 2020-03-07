import 'package:cognifeed_app/Models/passwordmodel.dart';
import 'package:meta/meta.dart';

abstract class ManagePasswordEvent {}

class ChangePasswordEvent extends ManagePasswordEvent {
  final ChangePassword changePassword;
  ChangePasswordEvent({@required this.changePassword})
      : assert(changePassword != null);
}

class ForgetPasswordEvent extends ManagePasswordEvent {
  final String email;
  ForgetPasswordEvent({@required this.email}) : assert(email != null);
}
