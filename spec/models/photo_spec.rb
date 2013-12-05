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
      expect(photo.title).not_to be_empty
      expect(photo.id).not_to be_empty
    end

    it 'fill out tags and sizes' do
      photo = Photo.text_search('kittens',1,1).first

      expect(photo.thumbnail).not_to be_empty
      expect(photo.fullsize).not_to be_empty
      expect(photo.tags.length).to be > 0
    end

  end
end