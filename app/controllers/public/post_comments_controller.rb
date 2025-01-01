class Public::PostCommentsController < ApplicationController
  
  # 新しいコメントを作成
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    # リクエスト元のページにリダイレクト
    redirect_to request.referer
  end
  
  # コメントを削除
  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
