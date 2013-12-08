require 'spec_helper'

describe 'photos' do
  
  context 'cleaning query string' do
    
    it 'can turn a single string into a tag' do
      tags = Photo.convert_query_to_tags("oneword")
      expect(tags).to eq("oneword")
    end

    it 'can turn multiple words into tags' do
      tags = Photo.convert_query_to_tags("one two three")
      expect(tags).to eq("one,two,three")
    end

    it 'can deal with extra whitespace with one word' do
      tags = Photo.convert_query_to_tags(" one  ")
      expect(tags).to eq("one")
    end

    it 'can deal with extra whitespace with multiple words' do
      tags = Photo.convert_query_to_tags("one          two three")
      expect(tags).to eq("one,two,three")
    end

    it 'can deal with an empty string' do
      tags = Photo.convert_query_to_tags("")
      expect(tags).to eq("")
    end

    it 'can deal with just empty space' do
      tags = Photo.convert_query_to_tags("  ")
      expect(tags).to eq("")
    end

    it 'can deal with commas' do
      tags = Photo.convert_query_to_tags("one,two three, four")
      expect(tags).to eq("one,two,three,four")
    end
  end

  context 'text searching with flickr API' do
    #this test actively tests agaisnt the flickr live api
    
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
      expect(photo.info[:description]).to_not be_nil
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