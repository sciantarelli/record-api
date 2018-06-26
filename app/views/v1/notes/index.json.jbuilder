json.data do
  json.array! notes do |note|
    json.partial! 'note', note: note
  end
end