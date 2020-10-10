class ValidateOtpRequest{
  String mailid;
  String otp;

  ValidateOtpRequest(String mailid, String otp){
    this.mailid = mailid;
    this.otp = otp;
  }
}