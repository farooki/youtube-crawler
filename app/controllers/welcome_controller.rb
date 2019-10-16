class WelcomeController < ApplicationController
  def index
   @records = YouTube.where(:test_1_pass => true, :test_2_pass => true).paginate(page: params[:page], per_page: 300)

  end

  def remove
      id = params[:id]
      YouTube.find(id).update(:test_2_pass => false)
  end

  def export
    require 'csv'
    CSV.open('/Users/muneebfarooqi/upwork_projects/dating_channels/list.csv', "wb") do |csv|
      csv << ['Channel Name', 'Channel URL',  'Channel Image',  'subscribers', 'Views', 'joined_at', 'Social Links','emails',  'Description']
      YouTube.where(:test_1_pass => true, :test_2_pass => true).reverse.each do |data|
        csv << [data.name, data.url, data.profile_url, data.subscribers, data.views, data.joined_at, data.links, data.emails, data.description]
      end
    end
  end
end




