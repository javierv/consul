# coding: utf-8
require 'rails_helper'

feature 'Debates' do
  scenario 'Shows up to 5 suggestions', :js do
    author = create(:user)
    login_as(author)

    create(:debate, title: "First debate has 1 vote", cached_votes_up: 1)
    create(:debate, title: "Second debate has 2 votes", cached_votes_up: 2)
    create(:debate, title: "Third debate has 3 votes", cached_votes_up: 3)
    create(:debate, title: "This one has 4 votes", description: "This is the fourth debate", cached_votes_up: 4)
    create(:debate, title: "Fifth debate has 5 votes", cached_votes_up: 5)
    create(:debate, title: "Sixth debate has 6 votes", description: 'This is the sixth debate',  cached_votes_up: 6)
    create(:debate, title: "This has seven votes, and is not suggest", description: 'This is the seven', cached_votes_up: 7)

    visit new_debate_path
    puts "Time before filling in with debate: #{Time.now - $INITIAL_TIME}"
    fill_in 'debate_title', with: 'debate'
    check "debate_terms_of_service"

    within('div#js-suggest') do
      expect(page).to have_content "You are seeing 5 of 6 debates containing the term 'debate'"
    end
  end

  scenario 'No found suggestions', :js do
    author = create(:user)
    login_as(author)

    create(:debate, title: "First debate has 10 vote", cached_votes_up: 10)
    create(:debate, title: "Second debate has 2 votes", cached_votes_up: 2)

    visit new_debate_path
    puts "Time before filling in with proposal: #{Time.now - $INITIAL_TIME}"
    fill_in 'debate_title', with: 'proposal'
    check "debate_terms_of_service"

    within('div#js-suggest') do
      expect(page).not_to have_content 'You are seeing'
    end
  end
end
