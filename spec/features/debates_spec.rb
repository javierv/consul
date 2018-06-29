# coding: utf-8
require 'rails_helper'

feature 'Debates' do
  scenario 'No found suggestions', :js do
    author = create(:user)
    login_as(author)

    create(:debate, title: "First debate has 10 vote", cached_votes_up: 10)
    create(:debate, title: "Second debate has 2 votes", cached_votes_up: 2)

    puts "#{Time.now - $INITIAL_TIME} starting with proposal"
    visit new_debate_path
    puts "#{Time.now - $INITIAL_TIME} before filling in with proposal"
    fill_in 'debate_title', with: 'proposal'
    check "debate_terms_of_service"
    puts "#{Time.now - $INITIAL_TIME} after checking terms with proposal"

    within('div#js-suggest') do
      expect(page).not_to have_content 'You are seeing'
    end
  end
end
