require 'rails_helper'
require 'monkey_patch'

describe MoviesController, type: 'controller' do
    fixtures :movies
    
    describe 'movie has a director' do
        it 'should respond to the similar_movies action' do
            get :similar_movies, { movie_id: movies(:star_wars).id }
        end
        
        it 'assigns similar movies to the template' do
            get :similar_movies, { movie_id: movies(:star_wars).id }
            expect(Movie.where(director: movies(:star_wars).director).size).to eq(2)
        end
    end
    
    describe 'movie does not have a director' do
        it 'should redirect to the index page on searching similar director movies' do
            get :similar_movies, { movie_id: movies(:steve_jobs).id }
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe 'GET#index action' do
        it 'should render the template view corresponding to index action' do
            get :index
            expect(response).to render_template('movies/index')
        end
        
        it 'should fetch all the movies' do
            expect(Movie).to receive(:all).and_return([movies(:star_wars), movies(:thx), movies(:steve_jobs), movies(:intersellar), movies(:blade_runner)])
            get :index
            expect(response.status).to eq(200)
        end
    end
    
    describe 'GET#new' do
        let!(:movie) { Movie.new }
    
        it 'should render the template view corresponding to new action' do
            get :new
            expect(response).to render_template('movies/new')
        end
    end
    
    describe 'GET#show' do
        before(:each) do
            get :show, id: movies(:star_wars).id
        end
    
        it 'should fetch the movie from the database' do
            expect(assigns(:movie)).to eql(movies(:star_wars))
        end
    
        it 'should render the template view corresponding to show action' do
            expect(response).to render_template('movies/show')
        end
    end
    
    describe 'GET#edit' do
        before do
            get :edit, id: movies(:steve_jobs).id
        end
    
        it 'should fetch the movie from the database' do
            expect(assigns(:movie)).to eql(movies(:steve_jobs))
        end
    
        it 'should render the template view corresponding to edit action' do
            expect(response).to render_template('movies/edit')
        end
    end
    
    describe 'PUT#update' do
        before(:each) do
            put :update, id: movies(:intersellar).id, movie: { title: movies(:blade_runner).title, director: movies(:blade_runner).director }
        end
    
        it 'should update the existing movie' do
            movies(:intersellar).reload
            expect(movies(:intersellar).title).to eql('Blade')
        end
    
        it 'should redirect to the show template of the movie' do
            expect(response).to redirect_to(movie_path(movies(:intersellar)))
        end
    end
    
    describe 'DELETE#destroy' do
        it 'should destroy a movie' do
            expect {
                delete :destroy, id: movies(:intersellar).id
            }.to change(Movie, :count).by(-1)
        end
    
        it 'redirects to movies#index after destroy' do
            delete :destroy, id: movies(:intersellar).id
            expect(response).to redirect_to(movies_path)
        end
    end
end
