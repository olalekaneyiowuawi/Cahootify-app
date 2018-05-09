require "rails_helper"

describe ImportMoviesController do
  describe "#create" do
    let(:url) { "https://www.movies.test"}
    it "delegates to the create movie interactor" do
      movie_creator = stub_movie_creator
      allow(movie_creator).to receive(:successful?).and_return(false)

      post :create, params: { url: url }

      expect(movie_creator).to have_received(:call)
    end

    context "when it successfully imports movies" do
      it "redirect to the create page" do
        movie_creator = stub_movie_creator
        allow(movie_creator).to receive(:successful?).and_return(true)

        post :create, params: { url: url }

        expect(controller).to redirect_to(import_movies_path)
      end

      it "sets success flash" do
        movie_creator = stub_movie_creator
        allow(movie_creator).to receive(:successful?).and_return(true)

        post :create, params: { url: url }

        expect(controller).to set_flash[:success]
      end
    end

    context "when it doesn't successful import the movies" do
      it "redirect to the create page" do
        movie_creator = stub_movie_creator
        allow(movie_creator).to receive(:successful?).and_return(false)

        post :create, params: { url: url }

        expect(controller).to redirect_to(import_movies_path)
      end

      it "sets flash danger" do
        movie_creator = stub_movie_creator
        allow(movie_creator).to receive(:successful?).and_return(false)

        post :create, params: { url: url }

        expect(controller).to set_flash[:danger]
      end
    end
  end

  def stub_movie_creator
    movie_creator = MoviesCreator.new(url: url)
    allow(MoviesCreator).to receive(:new).and_return(movie_creator)
    allow(movie_creator).to receive(:call)
    movie_creator
  end
end
