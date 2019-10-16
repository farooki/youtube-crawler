class YouTube < ApplicationRecord
  include Sidekiq::Worker
  def perform(keyword_id)
    #keyword = Keyword.find(keyword_id)
    #YouTube.get_front_page_data(keyword)
    YouTube.youtube_search_results(keyword_id)
  end

  def self.youtube_search_results(keyword_id)
    for i in 1..16
      keyword = Keyword.find(i)
      #browser = Browser.load_google_driver false
      keyword_url = "https://www.youtube.com/results?search_query=#{keyword.name.gsub(' ','+')}"
      browser.goto(keyword_url);
      for i in 1 ..30
        sleep(4)
        browser.driver.execute_script("window.scrollBy(0,2000)")
      end
      html = browser.html
      doc = Nokogiri::HTML(html)
      channels_data = []
      doc.css('#dismissable , .yt-formatted-string').each do |ch|
        channel_a = ch.css('#metadata a') rescue nil
        next unless channel_a

        channel_url = channel_a.first['href'] rescue nil
        next unless channel_url

        channel_text  = channel_a.first.text.strip
        channels_data << {
            channel_url: "https://youtube.com#{channel_url}",
            channel_text: channel_text
        }
      end

      channels_data.uniq.each do |ch|
        YouTube.find_or_create_by(
            name: ch[:channel_text],
            url: ch[:channel_url]
        )
      end
    end

  end

  def self.runner
    Keyword.where(:is_done => true).each do |keyword|
      YouTube.perform_async(keyword.id)
    end
  end

  def self.get_front_page_data(keyword)
    browser = Browser.load_google_driver
      keyword_url = "https://www.youtube.com/results?search_query=#{keyword.name.gsub(' ','+')}&sp=EgIQAg%253D%253D"
      browser.goto(keyword_url);
      for i in 1 ..20
        sleep(2)
        browser.driver.execute_script("window.scrollBy(0,2000)")
      end
      html = browser.html
      doc = Nokogiri::HTML(html)
      all_channels = doc.css('ytd-channel-renderer.style-scope.ytd-item-section-renderer')
      all_channels.each do |channel|
        begin
          url = channel.css('a')[0]['href']
          url = "https://youtube.com#{url}/about"
          image_url = "https:#{channel.css('yt-img-shadow img').first['src']}"
          subscribers_count = channel.css('span#subscribers').text.gsub(' subscribers', '')
          description = channel.css('yt-formatted-string#description').text
          name = channel.css('yt-formatted-string#text').first.text
          YouTube.find_or_create_by(
            name: name,
            url: url
          ).update(
              subscribers: subscribers_count,
              profile_url: image_url,
              description: description
          )
          rescue
        end
      end
      keyword.update(is_done: true)
    browser.close
  end

  def self.get_second_page_data
    browser = Browser.load_google_driver
    YouTube.all.where(:is_crawled => false).each do |yt|
      browser.goto yt.url
      sleep(3)
    end
  end


  def self.perform(id)
    browser = Browser.load_google_driver
    YouTube.where(:subscribers => nil).pluck(:id).shuffle.each do |id|
      next if !YouTube.find(id).subscribers.nil? && YouTube.find(id).is_crawled == true
      begin
        puts "===========================#{id}================================="
        yt = YouTube.find(id)
        #next if yt.is_crawled == true
        b_url = yt.url
        b_url = b_url + '/about' unless b_url.include?('/about')
        browser.goto b_url
        sleep(2)
        html = browser.html

        doc = Nokogiri::HTML(html)
        subscribers = doc.css('#subscriber-count').text.gsub(' subscribers', '').strip rescue '100k'
        profile_pic = doc.css('yt-img-shadow#avatar img').first['src'] rescue nil
        description = doc.css('div#description-container').first.text.strip rescue nil
        joined_at = doc.css('yt-formatted-string.style-scope.ytd-channel-about-metadata-renderer').map{|g| g if g.text.include?('Joined')}.compact.first.text.gsub('Joined', '').strip rescue nil
        views = doc.css('yt-formatted-string').map{|g| g if g.text.include?('views')}.compact.first.text.gsub('views', '').strip.gsub(',','').to_i rescue nil
        social = doc.css('div#link-list-container').first.css('a').map{|a| {url: a['href'], text: a.text.strip}} rescue []
        emails = get_email_addresses_from_doc_and_html(html) rescue []
        yt.update(
            profile_url: profile_pic,
            subscribers: subscribers || '100k',
            url: b_url,
            description: description,
            is_crawled: true,
            links: social,
            joined_at: joined_at,
            views: views,
            emails: emails,
            )
        rescue
      end
    end
    browser.close
  end



  def self.absolute_url(page_url, href)
    URI.join( page_url, href ).to_s
  end

  def self.get_email_addresses_from_doc_and_html(html)
    emails = html.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i) rescue []
    doc = Nokogiri::HTML html
    nodes = doc.xpath emails
    emails += nodes.collect {|n| n.value[7..-1]}
    unless emails.empty?
      stop_set = %w[.jpg .JPG .png .PNG .ico .ICO .gif .GIF .jpeg .JPEG .tiff .TIFF .webp .WEBP .eps .EPS .svg .SVG .ashx .ASHX .pdf .PDF example]
      emails = emails.map{|email| email unless stop_set.any? { |word| email.include?(word) } }.compact
    end
    emails = emails.uniq
    final_emails = []
    emails.uniq.each do |email|
      final_emails << email if validate_email(email)
    end
    final_emails.uniq
  end

  def self.validate_email(email)
    return false if email.length > 40
    return false if email.include?('=')
    return false if email.include?('%')
    return false if email.include?('?')
    return false if email.include?('/')
    return false unless email.include?('@')
    return false if email.include?('http')
    return false if email.include?('www.')
    return false if email.include?('>')
    return false if email.include?('<')
    return false if email.include?('[')
    return false if email.include?(']')

    true
  end

end



