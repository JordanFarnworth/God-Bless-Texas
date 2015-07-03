module Api::V1::Post
  include Api::V1::Json

  def post_json(post, includes = {})
    attributes = %w(id title description created_at state)

    api_json(post, only: attributes).tap do |hash|
      hash[:mini_image_url] = post.post_image.url(:thumb) if includes.include? 'dashboard'
      hash[:main_image_url] = post.post_image.url(:medium) if includes.include? 'dashboard'
      hash[:favorites_count] = post.favorites.count if includes.include? 'dashboard'
      hash[:page_views] = post.stats[:page_views] if includes.include? 'dashboard'
    end
  end


  def posts_json(posts, includes = {})
    posts.map { |p| post_json(p, includes) }
  end
end
