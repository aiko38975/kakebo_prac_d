class RecordsController < ApplicationController

  def index
  end

  def new
    @form = Form::RecordCollection.new
  end

  def create
    
    @form = Form::RecordCollection.new(record_collection_params)
    # binding.pry
    if @form.save
      redirect_to new_record_path
    else
      render :new
    end
  end

  private

  def record_collection_params
    params
    .require(:form_record_collection)
    .permit(records_attributes: [:recorded_at, :spending_way_id, :spending_pay_id, :price, :description, :user_id])
    .merge(user_id: current_user.id)
  end

end
