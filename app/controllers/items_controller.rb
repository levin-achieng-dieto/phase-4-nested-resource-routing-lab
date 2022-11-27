class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

def index
  #check if the request is from nested route or not
  if params[:user_id]
    user = User.find(params[:user_id])
    items = user.items
  else
    items = Item.all
  end
  render json: items, include: :user
end

def show
  item = Item.find(params[:id])
  render json: item, include: :user
end

def create
  item = Item.create(create_item)
  render json: item, status: :created
end

  private

  def render_not_found_response
    render json: { error: "Item not found"}, status: :not_found
  end

  def create_item
    params.permit(:name, :description, :price, :user_id)
  end

end
