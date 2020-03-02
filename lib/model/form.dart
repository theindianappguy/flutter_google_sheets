class FeedbackForm {

  String _name;
  String _email;
  String _mobileNo;
  String _feedback;

  FeedbackForm(this._name, this._email, this._feedback, this._mobileNo);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&email=$_email&mobileNo=$_mobileNo&feedback=$_feedback";


}