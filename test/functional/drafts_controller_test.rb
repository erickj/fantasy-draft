require 'test_helper'

class DraftsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drafts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create draft" do
    assert_difference('Draft.count') do
      post :create, :draft => { }
    end

    assert_redirected_to draft_path(assigns(:draft))
  end

  test "should show draft" do
    get :show, :id => drafts(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => drafts(:one).id
    assert_response :success
  end

  test "should update draft" do
    put :update, :id => drafts(:one).id, :draft => { }
    assert_redirected_to draft_path(assigns(:draft))
  end

  test "should destroy draft" do
    assert_difference('Draft.count', -1) do
      delete :destroy, :id => drafts(:one).id
    end

    assert_redirected_to drafts_path
  end
end
