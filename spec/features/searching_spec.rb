require 'spec_helper'

feature 'searching' do
  feature 'As a user I can search from the home page' do
    background do
      visit root_path
      binding.pry
    end
    
    scenario 'Can submit query' do
      fill_in 'query', with:'cat'
      click_on 'search-submit'

      raise 'not finished'
    end
  end
end