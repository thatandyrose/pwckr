FactoryGirl.define do
  factory :flickr_photo_mock do
    sequence(:id) {|n| n }
    sequence(:title) {|n| "Photo title #{n}" }
    sequence(:description) {|n| "Photo description #{n}" }
    sizes [
      {
      label:'large square',
      width:10,
      source:'http://nycprowler.com/prowler/wp-content/uploads/2013/10/cats-animals-kittens-background-us.jpg'
      },
      {
      label:'original',
      width:100,
      source:'http://nycprowler.com/prowler/wp-content/uploads/2013/10/cats-animals-kittens-background-us.jpg'
    }]
    sequence(:tags) {|n| ["cats_#{n}","kittens_#{n}","awesome_#{n}"] }
    sequence(:owner) {|n| {realname:"John_#{n}",username:"n00b_#{n}"} }
  end
end