notes.each{ |note| json.set! note.id, {
  id: note.id,
  name: note.name,
  content: note.content
}}