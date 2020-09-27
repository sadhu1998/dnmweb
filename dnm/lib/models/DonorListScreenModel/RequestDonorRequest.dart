class RequestDonorRequest{
  String _donorId;
  String _message;
  String _recipientId;

  String get donorId => _donorId;

  set donorId(String value) {
    _donorId = value;
  }

  RequestDonorRequest(String _donorId,String _message, String _recipientId){
    this._donorId = _donorId;
    this._message = _message;
    this._recipientId = _recipientId;
  }

  String get message => _message;

  String get recipientId => _recipientId;

  set recipientId(String value) {
    _recipientId = value;
  }

  set message(String value) {
    _message = value;
  }
}