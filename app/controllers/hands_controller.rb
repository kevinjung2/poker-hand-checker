require 'pry'

class HandsController < ApplicationController
  def new
    @hand = Hand.new
    @cards = Card.all
  end

  def create
    hand = Hand.create(hand_params)
  end

  def show
    
  end

  private
    def hand_params
      params.require(:hand).permit(card_ids: [])
    end
end
