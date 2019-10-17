part of imgur.client;

/// A service for comments.
/// https://apidocs.imgur.com/?version=latest#f9236628-fd66-4b4a-bf3c-fb65074dd560
class CommentService extends BaseService {
  CommentService(Imgur client) : super(client);

  /// Get information about a specific comment.
  /// https://apidocs.imgur.com/?version=latest#fba2b4a0-a0b9-47e0-80ae-f2f41201f2c3
  Future<BaseResponse<Comment>> getInfos(int commentId) async {
    return BaseResponse<Comment>.fromJson(json.decode(
        (await client.request(HttpMethod.GET, '/3/comment/$commentId')).body));
  }

  /// Creates a new comment, returns the ID of the comment.
  /// https://apidocs.imgur.com/?version=latest#01dce1de-f332-4a14-88fa-25f97cc13613
  Future<BaseResponse<RawId>> create(String imgId, String comment,
      {int parentId}) async {
    final Map<String, String> body = {
      'image_id': imgId,
      'comment': comment,
    };

    if (parentId != null) {
      body['parent_id'] = parentId.toString();
    }

    return BaseResponse<RawId>.fromJson(json.decode(
        (await client.request(HttpMethod.POST, '/3/comment', body: body))
            .body));
  }

  /// Delete a comment by the given id.
  /// https://apidocs.imgur.com/?version=latest#946e326e-47ba-4da7-a7fb-026c727e28ac
  Future<BaseResponse<bool>> delete(int commentId) async {
    return BaseResponse.fromJson(json.decode(
        (await client.request(HttpMethod.DELETE, '/3/comment/$commentId'))
            .body));
  }

  /// Get the comment with all of the replies for the comment.
  /// https://apidocs.imgur.com/?version=latest#8d5f32eb-64e1-436e-a0e1-2f9db82e7e67
  Future<BaseResponse<Comment>> getReplies(int commentId) async {
    return BaseResponse<Comment>.fromJson(json.decode(
        (await client.request(HttpMethod.GET, '/3/comment/$commentId/replies'))
            .body));
  }

  /// Vote on a comment. The vote parameter can only be set as up, down, or veto.
  /// https://apidocs.imgur.com/?version=latest#2d9d6c7b-7ff1-499d-ab7f-1b488063dc62
  Future<BaseResponse<bool>> vote(int commentId, VoteType vote) async {
    return BaseResponse.fromJson(json.decode((await client.request(
            HttpMethod.POST, '/3/comment/$commentId/vote/${fmtType(vote)}'))
        .body));
  }
}
