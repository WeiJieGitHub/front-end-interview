## N + 1 查询问题
原题写法查询次数过多。

```ruby
# 一次查询
posts = Post.limit(50)

# 五十次查询
posts.each do |post|
  puts post.author.name
end
```

经过下边改进以后可以大幅减少查询次数。

```ruby
posts = Post.includes(:author).limit(50)
posts.each do |post|
  puts post.author.name
end
```

源代码在「./answer.rb」中。
