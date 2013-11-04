class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #grab sort request from params (current) or session (historical)
    sort = params[:sort] || session[:sort]
    #Case match on sort param
    case sort
    when 'title' #when user asked for title sort
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date' #when user asked for release_date sort
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    #grab strings for all ratings from model method
    @all_ratings = Movie.all_ratings

    #grab ratings from params (current) or session (historical) or nil
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    #If we didn't find any selected_ratings, return all ratings in a hash to operate on later
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end

    #If session is not up to date, update it
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      #call back on sort
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    #finally, return the movies that are found in the ordered hash which meet selected_ratings
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
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
