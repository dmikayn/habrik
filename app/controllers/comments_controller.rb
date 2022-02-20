# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy
  before_action :set_post, only: %i[new destroy]
  before_action :check_access, only: :destroy

  def new
    @comment = Comment.new
    @comment = params[:comment]
    @post = params[:post]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = params[:post]

    p @comment

    respond_to do |format|
      if @comment.save
        if @post
          format.html { redirect_to post_url(@post), notice: 'Comment was successfully created.' }
        else
          format.html { redirect_to root_url, notice: 'Comment was successfully created.' }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_url(@post)
  end

  def comment_params
    params.permit(:contents, :comment_id)
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment])
  end

  def set_post
    @post = Post.find(params[:post])
  end

  def check_access
    p @comment
    p @post
    refuse_with_method_not_allowed unless @comment.user == current_user || @post.user == current_user
  end
end
