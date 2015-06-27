module Api::V1::Post
  include Api::V1::Json

  def post_json(post, includes = {})
    attributes = %w(id title description created_at state)

    api_json(user, only: attributes)
  end


  def posts_json(posts, includes = {})
    posts.map { |p| post_json(p, includes) }
  end
end
