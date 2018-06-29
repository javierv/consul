require 'rails_helper'

feature 'CKEditor' do

  scenario 'is present before & after turbolinks update page', :js do
    author = create(:user)
    login_as(author)

    puts "#{Time.now - $INITIAL_TIME} starting ckeditor"
    visit new_debate_path
    puts "#{Time.now - $INITIAL_TIME} after visiting new debate in ckeditor"

    expect(page).to have_css "#cke_debate_description"

    click_link 'Debates'
    puts "#{Time.now - $INITIAL_TIME} after clicking debates in ckeditor"
    click_link 'Start a debate'
    puts "#{Time.now - $INITIAL_TIME} after clicking start a debate in ckeditor"

    expect(page).to have_css "#cke_debate_description"
  end

end