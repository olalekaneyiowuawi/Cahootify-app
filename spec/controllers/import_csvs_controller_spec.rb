require "rails_helper"

describe ImportCsvsController do
  describe "#create" do
    let(:url) { "https://www.movies.test"}
    it "delegates to the create movie interactor" do
      people_creator = stub_people_creator
      allow(people_creator).to receive(:successful?).and_return(false)

      post :create, params: { url: url }

      expect(people_creator).to have_received(:call)
    end

    context "when it successfully imports movies" do
      it "redirect to the create page" do
        people_creator = stub_people_creator
        allow(people_creator).to receive(:successful?).and_return(true)

        post :create, params: { url: url }

        expect(controller).to redirect_to(new_import_csv_path)
      end

      it "sets success flash" do
        people_creator = stub_people_creator
        allow(people_creator).to receive(:successful?).and_return(true)

        post :create, params: { url: url }

        expect(controller).to set_flash[:success]
      end
    end

    context "when it doesn't successful import the movies" do
      it "redirect to the create page" do
        people_creator = stub_people_creator
        allow(people_creator).to receive(:successful?).and_return(false)

        post :create, params: { url: url }

        expect(controller).to redirect_to(new_import_csv_path)
      end

      it "sets flash danger" do
        people_creator = stub_people_creator
        allow(people_creator).to receive(:successful?).and_return(false)

        post :create, params: { url: url }

        expect(controller).to set_flash[:danger]
      end
    end
  end

  def stub_people_creator
    people_creator = PeopleCreator.new(url: url)
    allow(PeopleCreator).to receive(:new).and_return(people_creator)
    allow(people_creator).to receive(:call)
    people_creator
  end
end
