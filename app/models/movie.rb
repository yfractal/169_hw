class Movie < ActiveRecord::Base
	def self.sort_by_title
		Movie.find(:all,:order => "title")
	end
	def self.sort_by_release_date
		Movie.find(:all,:order => :release_date)
	end

	def self.sort_by_title(movies)
		movies.sort_by{|movie| movie.title}
	end
	def self.sort_by_release_date(movies)
		movies.sort_by{|movie| movie.release_date}
	end


	def self.all_ratings
		return ['G','PG','PG-13','R','NC-17']
	end

	def self.find_by_condition_order(raw_condition,order)
		condition = Movie.query_condition(raw_condition)
		Movie.find(:all,:conditions => condition, :order => order)
	end


	def self.query_condition(ratings)
		if ratings == nil
			return ""
		end
		condition =""
		ratings.each do |rating|
			condition += "rating = '#{rating}' or "
		end
		condition = condition[0..-4]
	end
	def self.choose_ratings(ratings)
		condition =""
		ratings.each do |rating|
			condition += "rating = '#{rating}' or "
		end
		condition = condition[0..-4]

		Movie.find(:all,:conditions => condition)		
	end
end
