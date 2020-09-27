class AddUserRequest {
  String bloodgroup;
  String city;
  String country;
  String district;
  String mail_notification;
  String mailid;
  String password;
  String phonenumber;
  String pincode;
  String sms_notification;
  String state;
  String town;
  String username;
  String fcmtoken;

  AddUserRequest(
      String bloodgroup,
      String city,
      String country,
      String district,
      String mail_notification,
      String mailid,
      String password,
      String phonenumber,
      String pincode,
      String sms_notification,
      String state,
      String town,
      String username,
      String fcmtoken) {
    this.bloodgroup = bloodgroup;
    this.city = city;
    this.country = country;
    this.district = district;
    this.mail_notification = mail_notification;
    this.mailid = mailid;
    this.password = password;
    this.phonenumber = phonenumber;
    this.pincode = pincode;
    this.sms_notification = sms_notification;
    this.state = state;
    this.town = town;
    this.username = username;
    this.fcmtoken = fcmtoken;
  }
}
