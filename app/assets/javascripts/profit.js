$(function(){
  $("#input-default").keyup(function(){
    var val = $("#input-default").val();
    var commission_result = Math.round(val * 0.1);
    var profit_result = (val - commission_result);
    $('.l-right').text(commission_result);
    $('.l-right').prepend('¥ ');
    $('.profit__right').text(profit_result);
    $('.profit__right').prepend('¥ ')
    if(profit_result == '') {
    $('.l-right').text('-');
    $('.profit__right').text('-');
    }
  });
});