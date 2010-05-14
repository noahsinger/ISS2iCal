# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_3.0_session',
  :secret      => '1627b370587a852b1042d728b162a09d326a41355c8c7e9d7c0961e8d22fe8e99bf74b7985c416baf5d3c6d5b429e329a354962a3e7ec716853e46fca68be2d9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
