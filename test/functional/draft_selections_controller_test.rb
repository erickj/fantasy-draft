require 'test_helper'

class DraftSelectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:draft_selections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create draft_selection" do
    assert_difference('DraftSelection.count') do
      post :create, :draft_selection => { }
    end

    assert_redirected_to draft_selection_path(assigns(:draft_selection))
  end

  test "should show draft_selection" do
    get :show, :id => draft_selections(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => draft_selections(:one).id
    assert_response :success
  end

  test "should update draft_selection" do
    put :update, :id => draft_selections(:one).id, :draft_selection => { }
    assert_redirected_to draft_selection_path(assigns(:draft_selection))
  end

  test "should destroy draft_selection" do
    assert_difference('DraftSelection.count', -1) do
      delete :destroy, :id => draft_selections(:one).id
    end

    assert_redirected_to draft_selections_path
  end
end
