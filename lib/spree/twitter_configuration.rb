class Spree::TwitterConfiguration < Spree::Preferences::Configuration
  preference :consumer_key, :string
  preference :consumer_secret, :string
  preference :access_token, :string
  preference :access_token_secret, :string
end