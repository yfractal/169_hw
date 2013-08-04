class Movie < ActiveRecord::Base
	validates :title, :presence => true

	def self.find_same_director_movies(id)
		director = Movie.find(id).director
		if director == nil or director == ""
			return nil
		end
		Movie.find(:all,:conditions => "director = '#{director}'")
	end

	def self.all_ratings
		return ['G','PG','PG-13','R','NC-17']
	end

	def self.find_by_condition_order(raw_condition,order)
		# raise raw_condition.inspect
		condition = Movie.query_condition(raw_condition)
		Movie.find(:all,:conditions => condition, :order => order)
	end


	def self.query_condition(ratings)

		if ratings == nil or ratings == ""
			return ""
		end

		condition =""
		ratings.each do |rating|
			condition += "rating = '#{rating}' or "
		end

		condition = condition[0..-4]
	end

end
