class ResponseModel{
  bool _issuccess;
  String _message;
  ResponseModel( this._issuccess, this._message,);
  String get message=>_message;
  bool get isSuccess=> _issuccess;
}