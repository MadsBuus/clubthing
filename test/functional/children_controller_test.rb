require 'test_helper'

class childrenControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:children)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create child" do
    assert_difference('child.count') do
      post :create, :child => { }
    end

    assert_redirected_to child_path(assigns(:child))
  end

  test "should show child" do
    get :show, :id => children(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => children(:one).to_param
    assert_response :success
  end

  test "should update child" do
    put :update, :id => children(:one).to_param, :child => { }
    assert_redirected_to child_path(assigns(:child))
  end

  test "should destroy child" do
    assert_difference('child.count', -1) do
      delete :destroy, :id => children(:one).to_param
    end

    assert_redirected_to children_path
  end
end
