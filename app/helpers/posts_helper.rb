module PostsHelper
  def liked_post?(pid, user)
    user.likes.find_by(post_id: pid).present?
  end
end
