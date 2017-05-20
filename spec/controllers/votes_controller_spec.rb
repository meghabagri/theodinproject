require 'rails_helper'

RSpec.describe VotesController, :type => :controller do
  let(:project) { double('Project', votes_for: votes) }
  let(:votes) { [vote] }
  let(:vote) { double('Vote') }
  let(:current_user) { double('User') }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
    allow(Project).to receive(:find).with('1').and_return(project)
    allow(project).to receive(:liked_by).with(current_user)
    allow(project).to receive(:unliked_by).with(current_user)
  end

  describe '#create' do

    it 'up votes the project' do
      expect(project).to receive(:liked_by).with(current_user)
      post :create, params: { lesson_id: '1', project_id: '1' }
    end

    it 'renders the the vote count in json' do
      post :create, params: { lesson_id: '1', project_id: '1' }
      expect(JSON.parse(response.body)).to eql(1)
    end
  end

  describe '#destroy' do
    let(:votes) { [] }

    it 'deletes the users upvote' do
      expect(project).to receive(:unliked_by).with(current_user)
      delete :destroy, params: { lesson_id: '1', project_id: '1' }
    end

    it 'renders the vote count in json' do
      delete :destroy, params: { lesson_id: '1', project_id: '1' }
      expect(JSON.parse(response.body)).to eql(0)
    end
  end
end
