class Form::RecordCollection < Form::Base
  FORM_COUNT = 2
  attr_accessor :records, :user_id

  def initialize(attributes = {})
    super attributes
    self.records = FORM_COUNT.times.map { Record.new() } unless self.records.present?
  end

  def records_attributes=(attributes)
    # self.records = attributes.map { |_, v| Record.new(v) }
    self.records = attributes.map { |_, v| Record.new(v.merge(user_id: user_id)) }
  end

  def save
    Record.transaction do
      self.records.map do |record|
        if record.availability
          record.save
        end
      end
    end
     return true
    rescue => e
     return false
  end
end
