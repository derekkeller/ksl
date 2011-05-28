require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get appliances" do
    get :appliances
    assert_response :success
  end

  test "should get books_and_media" do
    get :books_and_media
    assert_response :success
  end

  test "should get clothing" do
    get :clothing
    assert_response :success
  end

  test "should get computers" do
    get :computers
    assert_response :success
  end

  test "should get electronics" do
    get :electronics
    assert_response :success
  end

  test "should get furniture" do
    get :furniture
    assert_response :success
  end

  test "should get general" do
    get :general
    assert_response :success
  end

  test "should get homes" do
    get :homes
    assert_response :success
  end

  test "should get recreational_vehicles" do
    get :recreational_vehicles
    assert_response :success
  end

end
