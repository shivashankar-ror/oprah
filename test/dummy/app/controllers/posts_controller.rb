class PostsController < ApplicationController
  def show
    @post = present Post.new
  end
end
