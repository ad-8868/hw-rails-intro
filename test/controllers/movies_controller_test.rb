require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get movies_url
    assert_response :success
    assert_select "form#ratings_form"
    assert_select "input#ratings_G[checked]"
    assert_select "input#ratings_PG[checked]"
    assert_select "input#ratings_PG-13[checked]"
    assert_select "input#ratings_R[checked]"
  end

  test "should filter movies by selected rating" do
    get movies_url, params: { ratings: { "G" => "1" } }

    assert_response :success
    assert_select "#movie_#{movies(:one).id}"
    assert_select "#movie_#{movies(:two).id}", false
    assert_select "input#ratings_G[checked]"
    assert_select "input#ratings_R:not([checked])"
  end

  test "should show all movies and check all ratings when no ratings are selected" do
    get movies_url, params: { ratings: {} }

    assert_response :success
    assert_select "#movie_#{movies(:one).id}"
    assert_select "#movie_#{movies(:two).id}"
    assert_select "input#ratings_G[checked]"
    assert_select "input#ratings_R[checked]"
  end

  test "should get new" do
    get new_movie_url
    assert_response :success
  end

  test "should create movie" do
    assert_difference("Movie.count") do
      post movies_url, params: { movie: { description: @movie.description, rating: @movie.rating, release_date: @movie.release_date, title: @movie.title } }
    end

    assert_redirected_to movie_url(Movie.last)
  end

  test "should show movie" do
    get movie_url(@movie)
    assert_response :success
  end

  test "should get edit" do
    get edit_movie_url(@movie)
    assert_response :success
  end

  test "should update movie" do
    patch movie_url(@movie), params: { movie: { description: @movie.description, rating: @movie.rating, release_date: @movie.release_date, title: @movie.title } }
    assert_redirected_to movie_url(@movie)
  end

  test "should destroy movie" do
    assert_difference("Movie.count", -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
