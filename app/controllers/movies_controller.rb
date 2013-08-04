class MoviesController < ApplicationController
  
  def same_director
    id = params[:id]
    @movies = Movie.find_same_director_movies(id)
    if @movies == nil
      redirect_to root_path
      flash[:notice] = "'#{Movie.find(id).title}' has no director info"
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    begin
      @movie = Movie.find(id) # look up movie by unique ID
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "No such movie!!!"
      redirect_to movies_path
     end
  end

  def index
    # how to set condition
        # through redirect

    # when to redirect??
       #  filter,then select
          # params[:ratings] is nil but flash[:ratings] is seted
          # so I should redirect with wright params

    redirect_to :ratings => flash[:ratings],:sort => params[:sort] and return  if flash[:ratings] != nil and params[:ratings] == nil
    redirect_to :ratings => params[:ratings],:sort => flash[:sort] and return  if params[:sort] == nil and flash[:sort] != nil
    # get things wright
    @all_ratings = Movie.all_ratings
    ### here ########
    @selected_ratings = params[:ratings] ||flash[:ratings] || {}
    ###############
    if @selected_ratings == {}
      @all_ratings.each {|rating| @selected_ratings[rating] = 1}
    end

    flash[:ratings] = params[:ratings] if params[:ratings]
    flash[:sort] = params[:sort] if params[:sort]
    flash.keep
    # then do it 
    if params[:sort] == "title"
      order,@title_header ,@release_date_header= params[:sort] ,"hilite",nil
    elsif params[:sort] == "release_date"
      order,@release_date_header ,@title_header= params[:sort], "hilite",nil
    end
    @movies = Movie.find_by_condition_order(@selected_ratings.keys,order)
  end

  def new
    # default: render 'new' template
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movie_path(@movie)
    else
      flash[:notice] = ""
      render 'new'
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
