require 'sidekiq'
require 'active_job'

ActiveJob::Base.queue_adapter = :sidekiq

require "./data_anonymiser/base"
require "./data_anonymiser/version"
require "./data_anonymiser/anonymize"