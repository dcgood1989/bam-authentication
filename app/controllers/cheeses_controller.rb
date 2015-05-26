class CheesesController < ApplicationController

  def index
    if current_user
      @cheeses = Cheese.all
    else
      redirect_to '/'
      flash[:notice] = "You must register or log in before you can do that!"
    end
  end

  def new
    @cheese = Cheese.new
  end

  def create
    @cheese = Cheese.new(cheese_params)
    if @cheese.save
      flash[:notice] = "Cheese created successfully!"
      redirect_to cheeses_path
    else
      flash[:notice] = "Cheese not created"
      render :new
    end
  end

  def show
    @cheese = Cheese.find(params[:id])
  end

  def edit
    @cheese = Cheese.find(params[:id])
  end

  def update
    @cheese = Cheese.find(params[:id])
    if @cheese.update(cheese_params)
      flash[:notice] = "Cheese updated successfully!"
      redirect_to cheese_path(@cheese)
    else
      flash[:notice] = "Cheese not updated"
      render :show
    end
  end


  def destroy
    @cheese = Cheese.find(params[:id])
    @cheese.destroy
    flash[:notice] = "Deleted cheese: #{@cheese.name}"
    redirect_to cheeses_path
  end

  private

  def cheese_params
    params.require(:cheese).permit(:name, :price_per_lb)
  end
end
