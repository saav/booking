# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_testruby_session',
  :secret      => '18a2329b088a9abf604c8d0b4079ac15f06eee72a20fb9cfd1bcf1a891dceb1de0ab7966b67b257d666848c821bceff217fb5a3f38c0763b56b9828e784ee2ce'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
