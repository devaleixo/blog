class TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)
    @tag.save
  end

  private

  def tag_params
    params.require(:tag).permit(:title)
  end
end
