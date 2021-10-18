require 'pry'

class HandsController < ApplicationController
  def new
    @hand = Hand.new
    @cards = Card.all
  end

  def create
    hand = Hand.create(hand_params)
    redirect_to hand_path(hand)
  end

  def show
    @hand = Hand.find_by(id: params[:id])
    @score = @hand.analyze_hand
  end

  private
    def hand_params
      params.require(:hand).permit(card_ids: [])
    end
end
