# Be sure to restart your server when you modify this file.

# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end

# To enable root element in JSON for ActiveRecord objects.
# ActiveSupport.on_load(:active_record) do
#   self.include_root_in_json = true
# end

Date::DATE_FORMATS[:default] = '%d/%m/%Y'

# if you want to change the format of Time display then add the line below
Time::DATE_FORMATS[:default]= '%d/%m/%Y %H:%M:%S'

# if you want to change the DB date format.
Time::DATE_FORMATS[:db]= '%d/%m/%Y %H:%M:%S'
