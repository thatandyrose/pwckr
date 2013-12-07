require 'spec_helper'

#little test to make sure flickr mock works
describe 'flickr_photo_mock' do
  context 'text searching with flickr mock API' do
    before do
      #mock
      allow(FLICKR_API).to receive(:photos){FlickrPhotoMock}

      @collection = FLICKR_API.photos.search(text:'test',page:1,per_page:2)

      @mock_flickr_photo = FlickrPhotoMock.all.first
      @flickr_get_info_response = FLICKR_API.photos.getInfo(photo_id:@mock_flickr_photo.id)
      @flickr_get_sizes_response = FLICKR_API.photos.getSizes(photo_id:@mock_flickr_photo.id)
    end
    
    it 'can return a list of hash ids' do
      expect(@collection.length).to eq(2)
      expect(@collection[0]['id']).to be > 0
      expect(@collection[1]['id']).to be > @collection[0]['id']
    end

    it 'can persist collection across calls' do    
      expect(@flickr_get_info_response['title']).to eq(@mock_flickr_photo.title)
    end

    it 'can return the basic info' do
      expect(@flickr_get_info_response['title']).to eq(@mock_flickr_photo.title)
      expect(@flickr_get_info_response['description']).to eq(@mock_flickr_photo.description)
    end

    it 'can return tags' do
      expect(@flickr_get_info_response['tags'].length).to eq(@mock_flickr_photo.tags.length)
      expect(@flickr_get_info_response['tags'][0]['raw']).to eq(@mock_flickr_photo.tags[0])
    end

    it 'can return owner' do
      expect(@flickr_get_info_response['owner']['realname']).to eq(@mock_flickr_photo.owner[:realname])
      expect(@flickr_get_info_response['owner']['username']).to eq(@mock_flickr_photo.owner[:username])
    end

    it 'can return sizes' do
      expect(@flickr_get_sizes_response.length).to eq(2)
      expect(@flickr_get_sizes_response[0]['label']).to eq('large square')
      expect(@flickr_get_sizes_response[1]['label']).to eq('original')

      expect(@flickr_get_sizes_response[0]['width']).to eq(10)
      expect(@flickr_get_sizes_response[1]['width']).to eq(100)

      expect(@flickr_get_sizes_response[0]['source']).to_not be_empty
    end
  end
end