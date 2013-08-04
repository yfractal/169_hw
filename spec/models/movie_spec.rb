require 'spec_helper'
describe Movie do
	describe "find same director movies" do
		before :each do 
			@m1 = FactoryGirl.create(:movie,:director =>"d1")
			@m2 = FactoryGirl.create(:movie,:director =>"d1")
			@m3 = FactoryGirl.create(:movie,:director =>"d2")

			@m_nill = FactoryGirl.create(:movie,:director =>nil)
			@m_empty = FactoryGirl.create(:movie,:director =>"")


		end

		it "it should return the movies which have the same director" do 
			Movie.find_same_director_movies(@m1.id).should == [@m1,@m2]
		end
		it "it should return nil if the movie's director is nil or   '' " do 
			Movie.find_same_director_movies(@m_nill.id).should == nil
			Movie.find_same_director_movies(@m_empty.id).should == nil
		end
	end

	describe "for simple cov" do 
		before :each do 
			@o_1 = FactoryGirl.create(:movie,:title => "a",:rating =>"G")
			@o_2 = FactoryGirl.create(:movie,:title => "b",:rating => "R")
		end

		it "should return all ratings" do 
			Movie.all_ratings.should == ['G','PG','PG-13','R','NC-17']
		end

		it "should set the order by title" do 
			Movie.find_by_condition_order("", "title").should == [@o_1,@o_2]
		end

		it "filter by ratings" do 
			Movie.find_by_condition_order(["G"], "title").should == [@o_1]
		end

	end


end
