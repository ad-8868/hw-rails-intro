require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "all_ratings returns the supported movie ratings" do
    assert_equal %w[G PG PG-13 R], Movie.all_ratings
  end

  test "with_ratings returns all movies when ratings are nil" do
    assert_equal Movie.all.to_a, Movie.with_ratings(nil).to_a
  end

  test "with_ratings matches ratings case-insensitively" do
    assert_equal [movies(:one)], Movie.with_ratings(["g"]).to_a
  end
end
