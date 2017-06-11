posts = Post.includes(:author).limit(50)
posts.each do |post|
  puts post.author.name
end
