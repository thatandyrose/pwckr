![circleci status](https://circleci.com/gh/thatandyrose/pwckr/tree/master.png?circle-token=48f3b3e3bb4ca4d1094c39e7b7fb5a87166e4244)

<http://pwckr.herokuapp.com>

# PWCkr { */pu.ker/* }

## What The Hell Is PWCkr?

PWCkr lets you search for AND, *wait for it*, VIEW photos from flickr (the much celebrated and loved Yahoo! service)!

## What Cool Shit Does PWCkr Have?

I'm glad you asked.

### 1. It's Reponsive!

#### Desktop
![desktop PWCkr](https://www.dropbox.com/s/431qnei1tp82k0d/pwkr_desktop.png?dl=1)

#### Mobile
![desktop PWCkr](https://www.dropbox.com/s/poriaoscmpnpznw/pwkr_mobile.png?dl=1)

### 2. Discoverablity Achievement Unlocked!

View a photo and then click on the tags and discover... more photos. Great.

### 3. Tests With Delicious Mocking
  allow(ANY_CLASS).to receive(:get_todays_quote){"fuck yeah"}

#### Model Tests
PWCkr only has one Model, Photo, which implements the Flickr API. The model test talks to the real API to make sure we're parsing the api responses correctly.

The model completely wraps the api so that no other code touches the api.

#### Feature Tests with Mocking
The feature tests test the overall app behaviour and the app UI using a Flickr API mock class (since the real api is tested in our model test)

### 4. Async AND Control The Batch Size Of Your Javascript Calls!

The Flickr API is quite chatty. To avoid "locking the UI thread" most chatty calls are made asycnhrounously.

A compromise of delivery time (shipping this) and peformance (there's no caching stragegies nor a complete hand over to the client side) is to control the batch size of each call. This makes it easy to quickly tweak the batch size of each call together with the overal page size of each "page" to get a feel of peformance.

(check out line 29: https://github.com/thatandyrose/pwckr/blob/master/app/assets/javascripts/photos.js#L29)
![line 29](https://www.dropbox.com/s/uoiockd38zdht3n/line29.png?dl=1)

### 5. PWCkr is Continuously Integrated and Released!

![circleci status](https://circleci.com/gh/thatandyrose/pwckr/tree/master.png?circle-token=48f3b3e3bb4ca4d1094c39e7b7fb5a87166e4244)

### 6. Other Fun Facts

1. PWCkr runs on rails 3 and ruby (tuesday) 2
2. PWCkr tests use rspec + capybara with :selenium for the js:true tests.
3. No database is used (though postgres is configured).
4. Bootsrap 3, although layout is keep to ultra simple so not mnay boostrap "features" are used.

## Setting Up PWCkr

  $ git clone git@github.com:thatandyrose/pwckr.git
  $ cd pwckr
  $ bundle install
  $ rails s
  
You'll need firefox to run the tests. The FlickrAPI credentials are hardcoded (#TODO move them into application.yml)
