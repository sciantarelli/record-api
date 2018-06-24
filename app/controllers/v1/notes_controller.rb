class V1::NotesController < ApplicationController


  def index
    render json: notes, status: :ok
  end


  def create
    note.save
    render json: note, status: :created
  end


  def destroy
    if note.present? && note.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end


  private


  def note
    @_note ||= if params[:id]
                 Note.find(params[:id])
               else
                 Note.new(note_params)
               end
  end


  def notes
    @_notes ||= Note.all
  end


  def note_params
    params.require(:note).permit(:name, :content)
  end
end
