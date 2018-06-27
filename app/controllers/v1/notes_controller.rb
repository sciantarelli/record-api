class V1::NotesController < ApplicationController

  helper_method :note, :notes

  # TODO: Decide how to reject unauthorized requests where current user is nil. Possibly an authenticated controller or otherwise.

  # TODO: Add friendly id using the Note titles

  def index

  end


  def create
    unless note.save
      render json: { errors: note.errors.messages },
             status: :unprocessable_entity
    end
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
                 Note.find_by(
                     id: params[:id],
                     user_id: current_user.id
                 )
               else
                 current_user.notes.build(note_params)
               end
  end


  def notes
    @_notes ||= current_user.notes
  end


  def note_params
    params.require(:note).permit(:name, :content)
  end
end
