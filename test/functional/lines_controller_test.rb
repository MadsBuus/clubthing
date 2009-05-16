require 'test_helper'

class LinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line" do
    assert_difference('Line.count') do
      post :create, :line => { }
    end

    assert_redirected_to line_path(assigns(:line))
  end

  test "should show line" do
    get :show, :id => lines(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lines(:one).to_param
    assert_response :success
  end

  test "should update line" do
    put :update, :id => lines(:one).to_param, :line => { }
    assert_redirected_to line_path(assigns(:line))
  end

  test "should destroy line" do
    assert_difference('Line.count', -1) do
      delete :destroy, :id => lines(:one).to_param
    end

    assert_redirected_to lines_path
  end
end
