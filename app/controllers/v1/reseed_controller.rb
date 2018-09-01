require 'rake'

Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
Rails.application.load_tasks

class V1::ReseedController < ApplicationController

  def index
    p params

    ActiveRecord::Base.transaction do
      Note.destroy_all
      User.destroy_all
      User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')
      Note.connection.execute('ALTER SEQUENCE notes_id_seq RESTART WITH 1')

      if user_params
        u = User.new(user_params)

        u.skip_confirmation!
        u.save!
      end

      # TODO: Continue to flesh this out over time. Currently, it assumes there's only one user being created when creating notes, etc.

      if notes_params
        notes_params.each do |note_data|
          u.notes.create!(note_data)
        end
      end
    end

    head(:ok)

  end


  private


  def user_params
    params.permit(user: [:email, :password])[:user]
  end


  def notes_params
    params.permit(notes: [:name, :content])[:notes]
  end

end