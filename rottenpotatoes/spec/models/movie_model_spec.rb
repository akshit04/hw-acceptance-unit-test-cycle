require 'rails_helper'
require 'monkey_patch'

describe Movie do
  context 'multiple movies by the same director' do
    it 'matches movies with the same director' do
      movie1 = Movie.create!(id: 179, title: "Star Wars", director: "George Lucas")
      movie2 = Movie.create!(id: 180, title: "THX-1138", director: "George Lucas")
      results = Movie.similar_director_movies(movie1.title)
      expect(results).to eq([movie1, movie2])
    end        
  end    

  context 'single movie by that director' do
    it 'does not matches any other movies with the same director' do
      movie1 = Movie.create(id: 132, title: "Interstellar", director: "Christopher Nolan")
      movie2 = Movie.create(id: 136, title: "Blade Runner", director: "Ridley Scott")
      results = Movie.similar_director_movies(movie1.title)
      expect(results).not_to eq([movie1, movie2])
    end
  end
end 