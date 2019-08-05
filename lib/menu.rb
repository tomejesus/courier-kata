class Menu

  attr_reader :options

  def initialize
    @options = {
      :welcome => "Hello, world.
      I am the FundApps courier service bot.
      You can use me to get the cost of sending parcels.
      I'll provide you with numbered options as we go along but you can talk to me in English too.
      Whenever I give you numbered options just type in the number and press enter.
      If you want to give me instructions in English just type the instruction without quotation marks and press enter.
      If you'd like to turn me off at anytime just type and enter: 'exit'.
      If you'd like to stop what I'm doing and go back at anytime just type and enter: 'back'.
      To get started please type and enter: 'start'",
      :get_started => "Let's get started!",
      :main_menu => "Please select an option from the menu below.
      1: Add a new parcel to your current batch.
      2: Get a quote on a single item without adding it to your batch (you'll be able to add it later).
      3: View your current batch.
      4: Get the final quote for your current batch.
      0: Shut me down :( You will lose your progress if you do this.",
      :add_parcel => "Adding parcels to batches is what I love to do.",
      :request_length => "Can I get the length of the parcel (in cm)? ", # some repitition here
      :request_width => "Can I get the width of the parcel (in cm)? ",
      :request_height => "Can I get the height of the parcel (in cm)? ",
      :parcel_added => "Good news! I've successfully added that parcel to your batch."
    }
  end

  def welcome_message
    @options[:welcome]
  end

  def get_started
    @options[:get_started]
  end

  def main_menu
    @options[:main_menu]
  end

  def add_parcel
    @options[:add_parcel]
  end

  def request_length
    @options[:request_length]
  end

  def request_width
    @options[:request_width]
  end

  def request_height
    @options[:request_height]
  end

  def parcel_added
    @options[:parcel_added]
  end

end
