class MasterLookup < ApplicationRecord
  TEST_URL = 'https://www.youtube.com/results?search_query=dating&sp=EgIQAg%253D%253D'

  def self.keywords
    [
        'girls dating',
        'sex attraction',
        'find a girl for date',
        'find a boy for date',
        'girlfriend',
        'sex trend',
        'kiss hooks',
        'sexual relation ship',
        'boy and girl on couch',
        'girls sex feelings',
        'girls ditching',
        'girls kiss style',
        'girls sexual hobbies',
        'take a girl',
        'make a girl date',
        'girls personal life',
        'let me date',
        'my bf is sexy',
        'my gf is sexy'
    ]
  end
end
