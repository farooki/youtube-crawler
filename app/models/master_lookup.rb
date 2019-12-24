class MasterLookup < ApplicationRecord
  TEST_URL = 'https://www.youtube.com/results?search_query=dating&sp=EgIQAg%253D%253D'

  def self.keywords
    keywords_string = "become a dating coach --
    become a relationship coach--
    best dating coach in the world--
    best life coaching programs--
    best of lifecoach--
    best online dating--
    biker dating--
    business and lifestyle coach--
    business relationship coach--
    can a life coach help me--
    can i be a life coach--
    christian dating coach--
    coaching for coaches--
             country dating--
               dating--
               dating a coach--
               dating agency--
               dating and relationship coach--
               dating coach--
               dating coach advice-
               dating coach for men--
                            dating coach for women--
                                         dating coach london--
                                           dating coach nyc--
                                           dating coach online--
                                           dating coach tips--
                                           dating coach uk--
                                           dating for professionals--
                                                  disabled dating--
                                                    female dating coach--
                                                    female life coach--
                                                    female relationship coach--
                                                    gay dating--
                                                    gay online dating--
                                                    how to become a life coach in canada--
                                                    how to become a professional life coach--
                                                    how to become a relationship coach--
                                                    i want a life coach--
                                                    international dating--
                                                    japanese dating--
                                                    jewish dating--
                                                    life and relationship coach--
                                                    life as a life coach--
                                                    life coach information--
                                                    life coach rates--
                                                    life coach requirements--
                                                    lifecoach--
                                                    male dating coach--
                                                    mature dating--
                                                    millionaire dating--
                                                    mystery dating coach--
                                                    online dating--
                                                    online dating coach--
                                                    online dating coach for men--
                                                                        online dating profile coach--
                                                                          online dating reviews--
                                                                          personal dating coach--
                                                                          professional dating coach--
                                                                          relationship coach--
                                                                          relationship coach certification--
                                                                          relationship coach for men--
                                                                                             relationship coach for women--
                                                                                                                relationship coach india--
                                                                                                                  relationship coach los angeles--
                                                                                                                  relationship coach near me--
                                                                                                                  relationship coach nyc--
                                                                                                                  relationship coach uk--
                                                                                                                  relationship coach youtube--
                                                                                                                  spiritual dating--
                                                                                                                  the dating coach--
                                                                                                                  the relationship coach--
                                                                                                                  to become a life coach--
                                                                                                                  top 10 life coaches--
                                                                                                                  top dating sites--
                                                                                                                  top life coaches in the world--
                                                                                                                  vegetarian dating--
                                                                                                                  what does a life coach do exactly--
                                                                                                                  what does a life coach make--
                                                                                                                  what is a relationship coach--
                                                                                                                  where can i get a life coach"
    keywords_string.split('--').map{|kw| kw.strip}
  end
end
