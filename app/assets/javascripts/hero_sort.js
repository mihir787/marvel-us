$(document).ready(function(){

    $('#female').click(function(){
      $('.female').show();
      $('.male').hide();
    })

    $('#male').click(function(){
      $('.female').hide();
      $('.male').show();
    })

    $('#all').click(function(){
      $('.female').show();
      $('.male').show();
    })
  });

