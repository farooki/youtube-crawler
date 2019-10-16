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
    CSV.open('/home/muneeb/upwork_projects/youtube-crawler/public/list.csv', "wb") do |csv|
      csv << ['Channel Name', 'Channel URL',  'Channel Image',  'subscribers', 'Views', 'joined_at', 'Social Links','emails',  'Description']
      YouTube.all.reverse.each do |data|
        next if data.subscribers.nil?
        subscriber = '0'
        if data.subscribers.to_s.include?('K')
          subscriber = (data.subscribers.sub('K','').strip.to_f * 1000.0)
        end

        if data.subscribers.to_s.include?('M')
          subscriber = (data.subscribers.sub('M','').strip.to_f * 100000.0)
        end

        if subscriber.to_i < 10000
          puts "================#{data.subscribers}=============="
          next
        end

        csv << [data.name, data.url, data.profile_url, data.subscribers, data.views, data.joined_at, data.links, data.emails, data.description]
      end
    end
  end
end




