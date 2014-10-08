class HomesController < ApplicationController
  before_filter :validate_url, only: :parse
  def index
  end

  def parse
    if params[:url]
      agent = Mechanize.new
      page = agent.get(params[:url])

      page.content # Get the resulting page as a string
      str = page.body # Get the body content of the resulting page as a string
      str = str.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '_')
      # page.search(".somecss")

      output = File.open( "#{Rails.root}/app/views/homes/parse.html.erb","w" )
      output << str
      output.close
    end
  end

  def validate_url
     require 'uri'
      uri = URI.parse(params[:url])
      redirect_to root_path and return unless uri.kind_of?(URI::HTTP)
  end

end
