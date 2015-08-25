$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scorm_cloud_client'
require 'factory_girl'

Dir[('./spec/support/**/*.rb')].each { |file| require file }

FactoryGirl.find_definitions
