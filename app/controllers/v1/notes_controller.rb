class V1::NotesController < ApplicationController
  before_action :authenticate_request!,
                only: [:create, :destroy] # TODO: Remove this when auth is back in place (so index can pull notes for now without auth)

  helper_method :note, :notes


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
    @_notes ||= Note.all
    # TODO: Change above method to:
    # @_notes ||= current_user.notes
  end


  def note_params
    params.require(:note).permit(:name, :content)
  end
end
