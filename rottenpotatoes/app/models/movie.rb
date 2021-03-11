class Movie < ActiveRecord::Base
    def self.all_ratings
        self.select(:rating).map(&:rating).compact.uniq
    end
    
    def self.with_ratings(ratings_list, header: nil)
        ratings = ratings_list.present? ? ratings_list.keys : all_ratings
        ratings = ratings.map { |rating| rating.upcase }
        return self.where(rating: ratings) unless header.present?
        return self.where(rating: ratings).order(header) if header.present?
    end
    
    def self.similar_director_movies(title)
        director = Movie.find_by(title: title).director
        return nil if director.blank? or director.nil?
        Movie.where(director: director)
    end
end
