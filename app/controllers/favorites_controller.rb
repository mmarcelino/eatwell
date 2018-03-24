class FavoritesController < ApplicationController
  before_action :set_restaurant

  def index
    @favorite = Favorite.all
  end

  def create
    @favorite = Favorite.new
    @favorite.restaurant = @restaurant
    @favorite.user = current_user

    if @favorite.save
      # redirect_to restaurants_path
      respond_to do |format|
        # format.html { redirect_to restaurants_path }
        format.js  # <-- will render `app/views/favorites/create.js.erb`
       end
    else
      respond_to do |format|
        format.html { render 'restaurants/show' }
        format.js  # <-- idem
      end
    end
  end



    # if Favorite.create(favorited: @restaurant, user: current_user)
    #   redirect_to @restaurant, notice: 'Restaurant has been favorited'
    # else
    #   redirect_to @restaurant, alert: 'Something went wrong...'
    # end

  def destroy
    @favorite = Favorite.find(params[:id])

    @favorite.delete
    @favorite = nil
    respond_to do |format|
        format.html { redirect_to restaurants }
        format.js  # <-- will render `app/views/favorites/destroy.js.erb`
    end


  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
