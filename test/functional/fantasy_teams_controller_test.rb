require 'test_helper'

class FantasyTeamsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fantasy_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fantasy_team" do
    assert_difference('FantasyTeam.count') do
      post :create, :fantasy_team => { }
    end

    assert_redirected_to fantasy_team_path(assigns(:fantasy_team))
  end

  test "should show fantasy_team" do
    get :show, :id => fantasy_teams(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fantasy_teams(:one).id
    assert_response :success
  end

  test "should update fantasy_team" do
    put :update, :id => fantasy_teams(:one).id, :fantasy_team => { }
    assert_redirected_to fantasy_team_path(assigns(:fantasy_team))
  end

  test "should destroy fantasy_team" do
    assert_difference('FantasyTeam.count', -1) do
      delete :destroy, :id => fantasy_teams(:one).id
    end

    assert_redirected_to fantasy_teams_path
  end
end
