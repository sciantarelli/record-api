notes.each{ |note| json.set! note.id, {
  id: note.id.to_s,
  name: note.name,
  content: note.content
}}