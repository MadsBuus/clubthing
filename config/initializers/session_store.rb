# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_giertrud_session',
  :secret      => '502577932d71be772fcca4f565954b1d2788d744c6fffca6db8615be4821f59d91ac28058a46b6f7f35895758abaa83a22d9f970fcad9b61825bac7e636e003c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
