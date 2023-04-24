class Form::RecordCollection < Form::Base
  FORM_COUNT = 10 #ここで、作成したい登録フォームの数を指定
  attr_accessor :records 

  def initialize(attributes = {})
    super attributes
    self.records = FORM_COUNT.times.map { Record.new() } unless self.records.present?
  end

  def records_attributes=(attributes)
    self.records = attributes.map { |_, v| Record.new(v) }
  end

  def save
    Record.transaction do
      self.records.map do |record|
        if record.availability # ここでチェックボックスにチェックを入れている商品のみが保存される
          record.save
        end
      end
    end
      return true
    rescue => e
      return false
  end
end
