require 'spec_helper'

describe 'home/index.html.haml', :type => "view" do
  before(:each) do
    controller.stub(:current_user) { nil }
    render
  end

  it 'should have a heading' do
    assert_select "h1", "Pear"
  end

  context 'signed out' do
    it 'should have a fancy sign in button' do
      assert_select "a[href=#{user_omniauth_authorize_path(:github)}]"
    end
  end

  context 'signed in' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      controller.stub(:current_user) { @user }
      render
    end
    it 'has a sign out link' do
      assert_select "a", "Sign out."
    end
    it 'has a form for your availability and time zone' do
      assert_select 'form' do
        assert_select 'input[type=checkbox]'
        assert_select 'select#user_time_zone'
        assert_select 'input[type=submit]'
      end
    end
  end

end
