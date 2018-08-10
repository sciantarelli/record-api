note = {
    id: note.id.to_s,
    name: note.name,
    content: note.content
}

json.call(
  note,
  :id,
  :name,
  :content
)