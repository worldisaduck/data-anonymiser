require './data_anonymiser/anonymize_record'
require './data_anonymiser/checker'

class DataAnonymiser::Anonymize < ActiveJob::Base
  
  def perform(models: nil, date_time: 0)
    models = get_models if models.nil?
    names_to_replace = models.select { |m| m.any_name_attributes? && m.updated_at > date_time }
    emails_to_replace = models.select { |m| m.any_email_attributes? && m.updated_at > date_time }

    emails_to_replace.each { |record| DataAnonymiser::AnonymizeRecord.perform_later(record: record, attribute: :email) }
    names_to_replace.each { |record| DataAnonymiser::AnonymizeRecord.perform_later(record: record, attribute: :name) }
  end

  def get_models
    tables = ActiveRecord::Base.connection.tables.map { |t| t.capitalize.singularize.camelize }
  
    tables.map! do |t|
      begin 
        eval(t)
      rescue NameError
        next
      end
    end
    tables.compact!
  end

end