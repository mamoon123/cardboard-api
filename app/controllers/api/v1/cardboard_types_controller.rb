class Api::V1::CardboardTypesController < ApplicationController

  def index
    @cardboard_types = CardboardType.all
    respond_to do |format|
      if @cardboard_types
        format.json { render json: { message: 'Cardboard Type List', cardboard_type: @cardboard_types, status: 200 }}
      else
        format.json { render json: { message: 'Orders not found', cardboard_type: []}, status: 401}
      end
    end
  end
end
