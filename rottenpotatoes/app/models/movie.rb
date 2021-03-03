class Movie < ActiveRecord::Base
    def self.simililar_director_movies(director: nil)
        return nil if director.blank? or director.nil?
        Movie.where(director: director)
    end
end
