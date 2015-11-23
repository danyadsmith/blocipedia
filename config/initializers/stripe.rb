 # Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
  
   publishable_key: ENV['STRIPE_TEST_PK'],
   secret_key: ENV['STRIPE_TEST_SK']
 }
 
 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]
