var homeSearchForm = (function(){
  var init = function(){
    $('.home .query').focus(function(){
      $('form.photo-search .btn').fadeIn('slow');
    });
  };
  
  //self initiate
  $(function(){
    init();
  });

  return {}; //expose api if desired
})();