class Photo
  attr_accessor :id,:info,:urls
  
  def info
    #lazy loading
    if !@info
      self.info = Photo.extract_info(FLICKR_API.photos.getInfo(photo_id:self.id))
    end
    @info
  end

  def urls
    #lazy loading
    if !@urls
      self.urls = Photo.extract_urls(FLICKR_API.photos.getSizes(photo_id:self.id))
    end
    @urls
  end

  def self.text_search(query,page = 1,page_size = 20) 
    ids = FLICKR_API.photos.search(text:query,page:page,per_page:page_size).map{|r|r['id']}
    
    ids.map{|i| Photo.find(i,{with_info:false,with_urls:true})}
  end

  def self.find(photo_id,options = {with_info:true,with_urls:true})
    p = Photo.new
    p.id = photo_id.to_i

    if options[:with_info]
      #eager loading
      response = FLICKR_API.photos.getInfo(photo_id:photo_id)
      p.info = extract_info(response)
    end

    if options[:with_urls]
      #eager loading
      sizes = FLICKR_API.photos.getSizes(photo_id:photo_id)
      p.urls = extract_urls(sizes)
    end

    p
  end

  private

  def self.extract_info(flickr_get_info_response)
    {
      tags:extract_tags(flickr_get_info_response),
      author:extract_author(flickr_get_info_response),
      title:flickr_get_info_response['title'],
      description:flickr_get_info_response['description']
    }
  end

  def self.extract_urls(flickr_get_sizes_response)
    sizes = flickr_get_sizes_response
    {
      thumbnail:sizes.select{|s|s['label'].downcase == 'large square'}[0]['source'],
      fullsize:sizes.sort_by{|s| -s['width'].to_i}[0]['source']
    }
  end

  def self.extract_tags(flickr_get_info_response)
    flickr_get_info_response['tags'].map{|t|t['raw'].strip}
  end
  
  def self.extract_author(flickr_get_info_response)
    owner = flickr_get_info_response['owner']
    {
      name:owner['realname'],
      url:"http://www.flickr.com/photos/#{owner['username']}"
    }
  end
end