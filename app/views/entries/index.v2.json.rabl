collection @entries
cache @entries
attributes :id, :name, :winner, :avatar_url
node :time do |e|
  Time.now
end
