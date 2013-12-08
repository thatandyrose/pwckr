var homeSearchForm = (function(){
  var init = function(){
    $('.query').focus(function(){
      $('form.photo-search .btn').fadeIn('slow');
    });
  };
  
  //self initiate
  $(function(){
    init();
  });

  return {}; //expose api if desired
})();

var photoPager = (function(){
  var batch_size;
  var calls;
  var url;
  var page_size;
  var query;
  var current_page;
  var call_counter;
  var statusEl;
  var loadMoreEl;
  var returnedCount;

  var init = function(options){
    batch_size = 3;
    url = options.url;
    page_size = options.page_size;
    query = options.query;
    calls = Math.ceil(page_size/batch_size);

    statusEl = $('#sync-status');
    loadMoreEl = $('#load-more');

    returnedCount = 0;

    attacheLoadMoreHandler();
  };

  var attacheLoadMoreHandler = function(){
    loadMoreEl.click(function(){
      loadPage(current_page+1);
    });
  };

  var loadPage = function(page){
    var body = $('body');
    body.removeClass('page-done');
    body.addClass('page-loading');
    
    loadMoreEl.hide();
    statusEl.show();
    statusEl.html(" | loading photos <i class='fa fa-cogs'></i>");
    
    
    call_counter = 0;
    getPhotos(page,batch_size);
      
  };

  var pageDone = function(){
    call_counter = 0;
    
    var body = $('body');
    body.removeClass('page-loading');
    body.addClass('page-done');
    
    statusEl.fadeOut('slow');
    loadMoreEl.fadeIn('slow');
  };

  var getPhotos = function(page,_page_size){
    $.ajax({
      url:url,
      data:{query:query,page:page,page_size:_page_size,do_search:'true'},
      success:function(ret){
        current_page = page;
        call_counter++;
        if(call_counter >= calls){
          pageDone();
        }else{
          getPhotos(current_page+1,batch_size);
        }
      },
      error:function(err){
        statusEl.html(" | ERROR <i class='fa fa-bolt'></i> : could not load photos <em>:-(</em>");
      }
    });
  };

  return{
    loadPage:loadPage,
    init:init,
    current_page:current_page
  };
})();