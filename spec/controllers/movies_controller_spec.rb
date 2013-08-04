require 'spec_helper'
describe MoviesController do
	describe "find same director moves" do
		before :each do 
			@fake_resualts = [mock('movi1'),mock('movie2')]
			@m1 = FactoryGirl.create(:movie ,:director => "d1")
			@m2 = FactoryGirl.create(:movie ,:director => "d1")
			@m3 = FactoryGirl.create(:movie ,:director => nil)

		end

		it "should call the module method find_same_director_movies" do 
			Movie.should_receive(:find_same_director_movies).with("1")
			.and_return(@fake_resualts)
			get :same_director,:id => "1"
		end

		it "should redirect to the home page if no same director movies" do 
			Movie.stub(:find_same_director_movies).with("1").and_return(nil)
			get:same_director,:id => "1"
			# should redirect to the home page
			response.should redirect_to root_path
		end

		it "should redirect to the movies path  when ,find a 10000 id movie" do 
			get:show,:id => "10000"
			Movie.stub(:find).with("1000").and_raise(ActiveRecord::RecordNotFound)
			response.should redirect_to movies_path
		end
	end

	describe "simple cov" do 
		before :each do 
			@m1 = FactoryGirl.create(:movie ,:director => "d1",:title => "c")
			@m2 = FactoryGirl.create(:movie ,:director => "d1",:title => "b")
			@m3 = FactoryGirl.create(:movie ,:director => nil,:title => "a")
		end

		it "edit " do 
			Movie.should_receive(:find).with("#{@m1.id}")
			.and_return(@m1)
			get:edit,:id => @m1.id
		end

		it "destroy" do 
			c = Movie.all.count
			delete :destroy,:id => @m1.id
			Movie.all.count.should == c - 1
		end

		it "new" do 
			get :new			
		end

		it "create"do 
			post :create, :movie => {:title => "new"}
			Movie.last.title.should == "new"			
		end

		it "create invaild" do 
			post :create, :movie => {}
			# response.should redirect_to movies_path
		end

		it "update" do 
			put :update, {:id => @m1.to_param}
			response.should	redirect_to(movie_path(@m1))		
		end

		it "index" do 
			puts "in index"
			get :index 
			assigns(:movies).should == [@m1,@m2,@m3]
		end

		it "index" do 
			get :index ,:sort => "title"
			assigns(:movies).should == [@m3,@m2,@m1]
		end

		it "index" do 
			get :index ,:sort => "release_date"
			assigns(:movies).should == [@m1,@m2,@m3]
		end

	end 
end
