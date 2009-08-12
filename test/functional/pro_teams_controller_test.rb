require 'test_helper'

class ProTeamsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pro_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pro_team" do
    assert_difference('ProTeam.count') do
      post :create, :pro_team => { }
    end

    assert_redirected_to pro_team_path(assigns(:pro_team))
  end

  test "should show pro_team" do
    get :show, :id => pro_teams(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pro_teams(:one).id
    assert_response :success
  end

  test "should update pro_team" do
    put :update, :id => pro_teams(:one).id, :pro_team => { }
    assert_redirected_to pro_team_path(assigns(:pro_team))
  end

  test "should destroy pro_team" do
    assert_difference('ProTeam.count', -1) do
      delete :destroy, :id => pro_teams(:one).id
    end

    assert_redirected_to pro_teams_path
  end
end
