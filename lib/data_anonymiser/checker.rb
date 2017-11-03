require 'rujitsu/range'

module DataAnonymiser::Base

  def any_email_attributes?
    columns = self.class.column_names.select { |c| c =~ /email|mail/ } 
    columns.any?
  end

  def any_name_attributes?
    columns = self.class.column_names.select { |c| c =~ /name/ } 
    columns.any?
  end

  def anonymize_name
    attributes = self.class.column_names.select { |c| c =~ /name/ }
    attributes.each { |attr| self.update_attribute(attr.to_sym, 5.random_letters) }
    self
  end

  def anonymize_email
    attributes = self.class.column_names.select { |c| c =~ /email|mail/ }
    attributes.each { |attr| self.update_attribute(attr.to_sym, "#{self.id}@example.com") }
    self
  end

end

ActiveRecord::Base.send(:include, DataAnonymiser::Base)