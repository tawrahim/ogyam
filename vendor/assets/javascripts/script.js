/*
 * All the plugins init are in this file
 *
 */
var map;
$(document).ready(function() {

  // Scroll to top
  $.scrollUp({
     scrollText: '', // Text for element
  });
  
  // activate carousels
  $('#mobile-carousel').carousel();
  $('#testimonials-carousel').carousel();
  
  // init fitvids plugin
  $(".video").fitVids();

  
  // sliding contact form
  $('.contact-btn').click( function(){
    if($(this).hasClass('closed')) {
      $('.contact-form-inner').toggle();
      $(this).removeClass('closed').addClass('open');
    } else {
      $('.contact-form-inner').toggle();
      $(this).removeClass('open').addClass('closed');
    }
  });
  
  // ajax contact form
  $('.contact-form').submit(function(){
    $.post('contact-form.php', $(this).serialize(), function(data){
      $('.contact-form').html(data);
      $('.contact-form input, .contact-form textarea').val('');
    });				
    return false;
  });

  // ajax subscription
  $('.subsc-form').submit(function(){
    $.post('subscription.php', $(this).serialize(), function(data){
    
      $('.subsc-form > *').fadeIn();
      $('.subsc-form').html(data);
      $('.subsc-form input').val('');
    });				
    return false;
  });

});