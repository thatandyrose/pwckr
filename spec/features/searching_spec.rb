require 'spec_helper'

feature 'searching' do
  background do
    #mock the flickr API with our own AMAZING class
    allow(FLICKR_API).to receive(:photos){FlickrPhotoMock}
  end

  feature 'As a user I can search from the home page' do
    background do
      visit root_path
    end
    
    scenario 'Can submit query' do
      fill_in 'query', with:'cat'
      find('#search-submit').click
      expect(page).to have_title("cat photos")
    end
  end

  feature 'As a user I can search from the results page' do
    background do
      visit root_path

      fill_in 'query', with:'cat'
      find('#search-submit').click
    end

    scenario 'Can submit query' do
      fill_in 'query', with:'dog'
      click_on 'search-submit'

      expect(page).to have_title("dog photos")
    end
  end

  feature 'As a user I can view 20 search results',js:true do
    background do
      visit root_path
      fill_in 'query', with:'cat'
      
      find('#search-submit').click
    end

    scenario 'Can see 20 loaded photos' do
      expect(page).to have_selector('.page-done')
      binding.pry
      expect(all('.photo-box').length).to eq(21) #1 extra for the more button
    end

    scenario 'Can see more button' do
      expect(page).to have_selector('.page-done')
      expect(page).to have_selector('.load-more-container')
    end
  end

  feature 'As a user I can page the search results',js:true do
    background do
      visit root_path

      fill_in 'query', with:'cat'
      find('#search-submit').click
    end

    scenario 'can load page 2' do
      expect(page).to have_selector('.page-done')
      
      find('.load-more-container button').click
      expect(page).to have_selector('.page-done')

      expect(all('.photo-box').length).to eq(41) #1 extra for the more button
    end

    scenario 'can load page 3' do
      expect(page).to have_selector('.page-done')
      
      find('.load-more-container button').click
      expect(page).to have_selector('.page-done')

      find('.load-more-container button').click
      expect(page).to have_selector('.page-done')

      expect(all('.photo-box').length).to eq(61) #1 extra for the more button
    end
  end

  feature 'As a user I can see photo details' do
    background do
      visit root_path

      fill_in 'query', with:'cat'
      find('#search-submit').click
    end

    scenario 'can click on a search result to view details',js:true do
      expect(page).to have_selector('.page-done')
      photo_link = all('.photo-box a')[0]
      photo_id = photo_link.find('img')['data-id'].to_i

      photo_object = Photo.find(photo_id)

      photo_link.click

      expect(page).to have_content(photo_object.title)
      expect(page).to have_content(photo_object.tags.map{|t|"##{t}"}.join(" "))
      expect(all('.photo-tag').length).to eq(photo_object.tags.length)
    end
  end
end