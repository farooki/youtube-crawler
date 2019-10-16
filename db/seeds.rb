MasterLookup.keywords.each do |keyword|
  Keyword.find_or_create_by(:name => keyword)
end
