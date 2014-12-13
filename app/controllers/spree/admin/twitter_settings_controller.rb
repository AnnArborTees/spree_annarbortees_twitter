module Spree
  module Admin
    class TwitterSettingsController < Spree::Admin::BaseController

      def edit
        @preferences = [:consumer_key, :consumer_secret, :access_token, :access_token_secret]
        @config = Spree::TwitterConfiguration.new
      end

      def update
        config = Spree::TwitterConfiguration.new

        params.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end

        redirect_to edit_admin_twitter_settings_path
      end
    end
  end
end