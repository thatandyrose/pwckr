class Photo
  @@flickr = nil
  attr_accessor :thumbnail, :fullsize, :tags, :title, :id
  
  def self.text_search(query,page = 1,page_size = 20)
    
    photos = initiate_from_basic_info(flickr_api.photos.search(text:query,page:page,per_page:page_size))
    photos = fill_tags(photos)
    photos = fill_sizes(photos)
    photos
  end

  def self.initiate_from_basic_info(basic_info_collection)
    basic_info_collection.map do |bi|
      p = Photo.new
      p.title = bi['title']
      p.id = bi['id']
      p
    end
  end

  def self.fill_tags(photos)
    photos.each do |p|
      p.tags = flickr_api.photos.getInfo(photo_id:p.id).tags.map{|t|t['raw'].strip}
    end
    photos
  end

  def self.fill_sizes(photos)
    photos.each do |p|
      sizes = flickr_api.photos.getSizes(photo_id:p.id)
      p.thumbnail = sizes.select{|s|s['label'].downcase == 'square'}[0]['source']
      p.fullsize = sizes.sort_by{|s| -s['width'].to_i}[0]['source']
    end
    photos
  end

  def self.flickr_api
    if !@@flickr
      FlickRaw.api_key=FLICKR[:key]
      FlickRaw.shared_secret=FLICKR[:secret]
      @@flickr = flickr
    end
    @@flickr
  end
end