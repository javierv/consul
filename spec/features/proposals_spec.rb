# coding: utf-8
require 'rails_helper'

feature 'Proposals' do
  scenario 'Show up to 5 suggestions', :js do
    author = create(:user)
    login_as(author)

    create(:proposal, title: 'First proposal, has search term')
    create(:proposal, title: 'Second title')
    create(:proposal, title: 'Third proposal, has search term')
    create(:proposal, title: 'Fourth proposal, has search term')
    create(:proposal, title: 'Fifth proposal, has search term')
    create(:proposal, title: 'Sixth proposal, has search term')
    create(:proposal, title: 'Seventh proposal, has search term')

    visit new_proposal_path
    puts "#{Time.now - $INITIAL_TIME} before filling in with search"
    fill_in 'proposal_title', with: 'search'
    check "proposal_terms_of_service"
    puts "#{Time.now - $INITIAL_TIME} after checking terms with search"

    within('div#js-suggest') do
      expect(page).to have_content "You are seeing 5 of 6 proposals containing the term 'search'"
    end
  end

  scenario 'No found suggestions', :js do
    author = create(:user)
    login_as(author)

    create(:proposal, title: 'First proposal').update_column(:confidence_score, 10)
    create(:proposal, title: 'Second proposal').update_column(:confidence_score, 8)

    visit new_proposal_path
    puts "#{Time.now - $INITIAL_TIME} before filling in with imaginary"
    fill_in 'proposal_title', with: 'imaginary'
    check "proposal_terms_of_service"
    puts "#{Time.now - $INITIAL_TIME} after checking terms with imaginary"

    within('div#js-suggest') do
      expect(page).not_to have_content 'You are seeing'
    end
  end
end
