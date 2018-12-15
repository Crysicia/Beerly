class BarsController < ApplicationController

  before_action :manager_has_one_bar, only: [:new]
  before_action :manager_can_only_edit_their_bar, only: [:edit]

  def index
    @bars = Bar.all 
  end

  def show
    @bar = Bar.find(params[:id])
    @draft_beers = @bar.beer_lists.draft.up
    @bottle_beers = @bar.beer_lists.bottle.up
    @barwishlist = BarWishlist.new
  end

  def new
    @bar = Bar.new 
  end

  def update
    if address_or_name_blank
      redirect_to edit_managers_bar_path(current_manager.bar.id), alert: "Le nom ou l'adresse du bar ne peuvent être vides."
    else  
      @bar = Bar.find(params[:id])
      @bar.update(bar_params)
      redirect_to bar_path(@bar.id)
    end 
  end

  def edit
    @bar = Bar.find(current_manager.bar.id)
  end


  private 
    def bar_params
      params.require(:bar).permit(:name, :address, :photo, :opening_time, :happy_hours, :description)
    end 

end