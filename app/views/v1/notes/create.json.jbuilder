json.data do
  json.user do
    json.partial! 'note', note: note
  end
end