class ChargesController < ApplicationController

  def create
    @amount = 10_00
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )

   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: @amount,
     description: "WriteSpace Membership - #{current_user.email}",
     currency: 'usd'
   )

   flash[:notice] = "Your WriteSpace premium account has been activated, #{current_user.email}!"
   current_user.premium!
   redirect_to edit_user_registration_path(current_user) 

  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
  end

  def new
  @amount = 10_00

  @stripe_btn_data = {
   key: "#{ Rails.configuration.stripe[:publishable_key] }",
   description: "WriteSpace Premium Membership - #{current_user.name}",
   amount: @amount
  }
  end

end