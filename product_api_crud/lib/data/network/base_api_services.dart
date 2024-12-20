abstract class BaseApiServices {
  // GET API Request
  Future<dynamic> getGetApiResponse(String url);

  // POST API Request (create)
  Future<dynamic> getPostApiResponse(String url, dynamic data);

  // PUT or PATCH API Request (update)
  Future<dynamic> getUpdateApiResponse(String url, dynamic data);

  // DELETE API Request
  Future<dynamic> getDeleteApiResponse(String url);
}
