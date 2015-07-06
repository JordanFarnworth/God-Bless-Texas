module Api::V1::Comment
  include Api::V1::Json
  include Api::V1::User

  def comment_json(comment, includes = {})
    attributes = %w(id user_id post_id message state created_at)

    api_json(comment, only: attributes).tap do |hash|
      hash[:user] = comment.user if includes.include? 'user'
    end
  end


  def comments_json(comments, includes = {})
    comments.map { |c| comment_json(c, includes) }
  end
end
