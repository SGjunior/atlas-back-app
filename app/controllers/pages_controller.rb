class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @var = %W( john, mary, nicols )
  end
end
