//login requests

class LoginRequests{
  String email;
  String password;

  LoginRequests(this.email,this.password);
}

//register requests

class RegisterRequests{
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterRequests(
      this.userName,
      this.email,
      this.password,
      this.countryCode,
      this.mobileNumber,
      this.profilePicture);
}

