class ImportMoviesController < ApplicationController
  def create
    creator = PeopleCreator.new(url: movies_params[:url])
    creator.call
    process_movies_creator(creator)
  end

  private

  def process_movies_creator(creator)
    if creator.successful?
      flash[:success] = success_message_for(creator)
    else
      flash[:danger] = "Couldn't import records, try again"
    end
    redirect_to new_import_movie_path
  end

  def movies_params
    params.permit(:url)
  end

  def no_of_created_records(creator)
    creator.number_of_records_created
  end

  def success_message_for(creator)
    records = no_of_created_records(creator)
    "#{records} records were created"
  end

end
