module Api::V1::Post
  include Api::V1::Json

  def post_json(post, includes = {})
    attributes = %w(id title description created_at state)

    api_json(post, only: attributes).tap do |hash|
      hash[:mini_image_url] = post.post_image.url(:thumb)
      hash[:favorites_count] = post.favorites.count
      hash[:page_views] = post.stats[:page_views]
    end
  end


  def posts_json(posts, includes = {})
    posts.map { |p| post_json(p, includes) }
  end
end
