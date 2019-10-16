require 'watir'
class Browser < ApplicationRecord

  def self.load_google_driver(headless = false, browser_settings = nil, is_firefox = false)
    return (Watir::Browser.new :firefox, headless: false) if is_firefox
    if Rails.env.production?
      # Selenium::WebDriver::Chrome.driver_path = "#{Rails.root.to_s}/plugins/chromedriver"
      Selenium::WebDriver::Chrome::Service.driver_path = "#{Rails.root.to_s}/plugins/chromedriver"
    else
      #Selenium::WebDriver::Chrome.driver_path = "#{Rails.root.to_s}/plugins/mac/chromedriver"
      Selenium::WebDriver::Chrome::Service.driver_path = "#{Rails.root.to_s}/plugins/mac/chromedriver"
    end
    if browser_settings
      args = (headless == true ? ['--headless', '--disable-gpu'] : [])
      mobile_emulation = {
          :deviceMetrics    => {
              'width'       => browser_settings[:portrait][:width],
              'height'      => browser_settings[:portrait][:height],
              'pixelRatio'  => browser_settings[:pixel_ratio] },
          :userAgent        => browser_settings[:user_agent]
      }
      browser = Watir::Browser.new(:chrome, {:chromeOptions => {:mobileEmulation => mobile_emulation, :args => args}})
    else
      browser = Watir::Browser.new :chrome, headless: headless
    end
    browser
  end

end
