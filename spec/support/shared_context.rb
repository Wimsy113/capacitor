RSpec.shared_context "account login" do
  Given!(:current_account) { FactoryGirl.create(:account) }
  Given!(:time_zone) { time_zone(time_zone: "(GMT-04:00) Eastern Standard Time") }

  When do
    visit new_account_session_path
    fill_in "Email", with: current_account.email
    fill_in "Password", with: current_account.password
    click_button "Log in"
  end
end
