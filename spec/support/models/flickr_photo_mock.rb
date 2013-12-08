class FlickrPhotoMock
  @@all_photos = []
  
  attr_accessor :id,:title,:description,:sizes,:tags,:owner

  def self.search(o = {})
    Kaminari.paginate_array(all).page(o[:page]).per(o[:per_page]).map{|p|{'id'=>p.id}}
  end

  def self.getInfo(o={})
    all.select{|p|p.id == o[:photo_id].to_i}.map{|p|
      {
        'title'=>p.title,
        'description'=>p.description,
        'tags'=>p.tags.map{|t|{'raw'=>t}},
        'owner'=>{
          'realname'=>p.owner[:realname],
          'username'=>p.owner[:username]
        }
      }
    }.first
  end

  def self.getSizes(o={})
    all.select{|p|p.id == o[:photo_id].to_i}.map{|p|
      p.sizes.map do |s|
        {
          'label'=>s[:label],
          'source'=>s[:source],
          'width'=>s[:width]
        }
      end
    }.first
  end
  
  def self.all
    if !@@all_photos.any?
      @@all_photos = FactoryGirl.build_list(:flickr_photo_mock,100)
    end
    @@all_photos
  end
end