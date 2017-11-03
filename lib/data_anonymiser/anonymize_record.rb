class DataAnonymiser::AnonymizeRecord < ActiveJob::Base

  def perform(record: nil, attribute: nil)
    record.send("anonymize_#{attribute}".to_sym)
  end
end