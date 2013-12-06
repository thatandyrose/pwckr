require 'spec_helper'

describe 'photos' do
  context 'text searching' do

    it 'returns the correct number of results' do
      photos = Photo.text_search('kittens',1,5)
      expect(photos.length).to eq(5)
    end

    it 'paginates correctly' do
      photos_all = Photo.text_search('kittens',1,6)
      second_page = Photo.text_search('kittens',2,5)

      sixth_id = photos_all.last.id
      second_page_id = second_page.first.id

      expect(sixth_id).to eq(second_page_id) 
    end

    it 'fills out basic info' do
      photo = Photo.text_search('kittens',1,1).first
      
      expect(photo.id.to_s).not_to be_empty
      expect(photo.info.keys.length).to eq(4)
      expect(photo.info[:title]).to_not be_empty
      expect(photo.info[:description]).to_not be_empty
    end

    it 'fills out tags' do
      photo = Photo.text_search('kittens',1,1).first
      
      expect(photo.info[:tags].length).to be > 0
      expect(photo.info[:tags]).to_not include('',nil)
    end

    it 'fills out urls' do
      photo = Photo.text_search('kittens',1,1).first
      
      expect(photo.urls.length).to be > 0
      expect(photo.urls[:thumbnail]).to_not be_empty
      expect(photo.urls[:fullsize]).to_not be_empty
    end

  end
end