class Response<T> {
  String msg;

  T result;

  Response.ok(this.result);
  Response.error(this.msg);

  isOk() {
    return result != null;
  }

  @override
  String toString() {
    return 'Response{msg: $msg, result: $result}';
  }
}