class SuperherosController < ApplicationController

  def index
    if params[:gender] == "female"
      @superheros = page.female 
    elsif params[:gender] == "male"
      @superheros = page.male
    else
      @superheros = page
    end
  end

  def show
    @superhero = Superhero.find(params[:id])
  end

  private
  def page
    Superhero.paginate(page: params[:page], per_page: 6)
  end

end
