require 'test_helper'

class FantasyLeaguesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fantasy_leagues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fantasy_league" do
    assert_difference('FantasyLeague.count') do
      post :create, :fantasy_league => { }
    end

    assert_redirected_to fantasy_league_path(assigns(:fantasy_league))
  end

  test "should show fantasy_league" do
    get :show, :id => fantasy_leagues(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fantasy_leagues(:one).id
    assert_response :success
  end

  test "should update fantasy_league" do
    put :update, :id => fantasy_leagues(:one).id, :fantasy_league => { }
    assert_redirected_to fantasy_league_path(assigns(:fantasy_league))
  end

  test "should destroy fantasy_league" do
    assert_difference('FantasyLeague.count', -1) do
      delete :destroy, :id => fantasy_leagues(:one).id
    end

    assert_redirected_to fantasy_leagues_path
  end
end
