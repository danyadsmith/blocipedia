class ChargesController < ApplicationController

  def new
  authorize :charges
  @stripe_btn_data = {
   key: "#{ Rails.configuration.stripe[:publishable_key] }",
   description: "WriteSpace Premium Membership - #{current_user.name}",
   amount: 15_00
  }
  end  

  def create
    authorize :charges
   # Creates a Stripe Customer object, for associating
   # with the charge
   begin
     customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
     )

    customer.subscriptions.create(:plan => "blocipedia")
    current_user.stripe_customer_id = customer.id
    current_user.premium!

    flash[:notice] = "Your WriteSpace premium account has been activated, #{current_user.email}! Your trial period ends in 5 days."
      # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
   rescue Exception => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end
   redirect_to edit_user_registration_path(current_user) 
  end

  def edit
    authorize :charges
    @id = current_user.id
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    @subscriptions = customer.subscriptions.all
    
    @subscriptions.each do |subscription|
      @plan_id = subscription.plan.id
      @plan_name = subscription.plan.name
      @subscription_status = subscription.status
      @trial_begins = subscription.trial_start
      @trial_ends = subscription.trial_end
      @current_period_ends = subscription.current_period_end
    end
  end

  def destroy
    authorize :charges
    begin
      @id = current_user.id
      @stripe_id = current_user.stripe_customer_id
      current_user.standard!
      customer = Stripe::Customer.retrieve(@stripe_id)
      customer.subscriptions.first.delete
    rescue Exception => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
    redirect_to root_path
  end



end