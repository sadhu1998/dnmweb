class BloodRequestor {
  String donor_id;
  String message;
  String recipient_id;
  String phonenumber;
  String username;
  String bloodgroup;

  BloodRequestor(
      String donor_id, String message, String recipient_id, String phonenumber, String username, String bloodgroup) {
    this.donor_id = donor_id;
    this.message = message;
    this.recipient_id = recipient_id;
    this.phonenumber = phonenumber;
    this.bloodgroup = bloodgroup;
    this.username = username;
  }
  
  BloodRequestor.fromMap(Map<String,dynamic> requestMap){
    this.donor_id = requestMap['donor_id'];
    this.message = requestMap['message'];
    this.recipient_id = requestMap['receipent_id'];
    this.phonenumber = requestMap['phonenumber'];
    this.username = requestMap['username'];
    this.bloodgroup = requestMap['blood_group'];
    
  }
}
