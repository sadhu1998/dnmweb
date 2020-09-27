class DonorDetailModel {
  String username;
  String bloodgroup;
  String city;
  String state;
  String notifybutton;

  DonorDetailModel(String username, String bloodgroup, String city,
      String state, String notifybutton) {
    this.username = username;
    this.bloodgroup = bloodgroup;
    this.city = city;
    this.state = state;
    this.notifybutton = notifybutton;
  }

  DonorDetailModel.fromJson(Map<String, dynamic> donorDetailMap){
    this.username = donorDetailMap["username"];
    this.bloodgroup = donorDetailMap["bloodgroup"];
    this.city = donorDetailMap["city"];
    this.state = donorDetailMap["state"];
    this.notifybutton = 'notify';
  }
}
