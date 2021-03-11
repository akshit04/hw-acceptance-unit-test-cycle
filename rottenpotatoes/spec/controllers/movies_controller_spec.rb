require 'rails_helper'
require 'monkey_patch'

describe MoviesController, type: 'controller' do
    describe 'movie has a director' do
        it 'should respond to the similar_movies action' do
            movie1 = Movie.create!(id: 69, title: "Steve Jobs", director: "Danny Boyle")
            get :similar_movies, { movie_id: movie1.id }
        end
        
        it 'assigns similar movies to the template' do
          movie2 = Movie.create!(id: 89, title: "Star Wars", director: "George Lucas")
          movie3 = Movie.create!(id: 90, title: "THX-1138", director: "George Lucas")
          get :similar_movies, { movie_id: movie2[:id] }
          expect(Movie.where(director: movie2.director).size).to eq(2)
        end
    end
    
    describe 'movie does not have a director' do
        it 'should redirect to the index page on searching similar director movies' do
            movie = Movie.create!(id: 67, title: "Steve Jobs", director: "")
            get :similar_movies, { movie_id: movie.id }
            expect(response).to redirect_to(movies_path)
        end
    end
end
