class SearchController < ApplicationController
  def index
    search_field = params[:search].present? ? params[:search] : '*'
    category_id = params[:category].present? ? params[:category].to_i : nil

    @posts = if category_id
               Post.search(search_field, fields: %i[title body category_id], where: { category_id: })
             else
               Post.search(search_field, fields: %i[title body])
             end

    respond_to do |format|
      format.html { render :index }
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('posts',
                              partial: 'posts/posts',
                              locals: { posts: @posts })
      end
    end
  end
end
