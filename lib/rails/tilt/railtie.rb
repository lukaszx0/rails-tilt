module Parts
  class Railtie < Rails::Railtie
    initializer "rails_tilt.setup_action_pack", before: :add_view_paths do |app|
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.superclass.send(:include, Rails::Tilt::Rendering)
      end
    end
  end
end