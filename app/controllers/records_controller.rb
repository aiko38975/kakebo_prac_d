class RecordsController < ApplicationController

  def index
  end

  def new
    @form = Form::RecordCollection.new
  end

  def create
    @form = Form::RecordCollection.new(record_collection_params)
    if @form.save
      redirect_to records_path, notice: "商品を登録しました"
    else
      flash.now[:alert] = "商品登録に失敗しました"
      render :new
    end

  end

  private

    def record_collection_params
        params.require(:form_record_collection)
        .permit(records_attributes: [:recorded_at, :spending_way_id, :spending_pay_id, :price, :description, :availability])
    end


end
