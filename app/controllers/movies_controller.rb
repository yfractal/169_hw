class MoviesController < ApplicationController

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
    redirect_to :ratings => flash[:ratings],:sort => params[:sort] and return  if flash[:ratings] != nil and params[:ratings] == nil
    redirect_to :ratings => params[:ratings],:sort => flash[:sort] and return      if params[:sort] == nil and flash[:sort] != nil
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] ||flash[:ratings] || {}

    if @selected_ratings == {}
      @all_ratings.each {|rating| @selected_ratings[rating] = 1}
    end

    flash[:ratings] = params[:ratings] if params[:ratings]
    flash[:sort] = params[:sort] if params[:sort]
    flash.keep
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
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movie_path(@movie)
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
