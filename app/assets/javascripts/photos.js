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
  var batch_size = 1;
  var calls;
  var url;
  var page_size;
  var query;
  var current_page;
  var call_counter;
  var statusEl;
  var loadMoreEl;

  var init = function(options){
    url = options.url;
    page_size = options.page_size;
    query = options.query;
    calls = Math.ceil(page_size/batch_size);
    call_counter = 0;

    statusEl = $('#sync-status');
    loadMoreEl = $('#load-more');

    attacheLoadMoreHandler();
  };

  var attacheLoadMoreHandler = function(){
    loadMoreEl.click(function(){
      loadPage(current_page+1);
    });
  };

  var loadPage = function(page){
    loadMoreEl.hide();
    statusEl.show();
    statusEl.html(" | loading photos <i class='fa fa-cogs'></i>");
    
    getPhotos(page,batch_size);
      
  };

  var pageDone = function(){
    call_counter = 0;
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
        status.html(" | ERROR <i class='fa fa-bolt'></i> : could not load photos <em>:-(</em>");
      }
    });
  };

  return{
    loadPage:loadPage,
    init:init,
    current_page:current_page
  };
})();