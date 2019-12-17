$(document).on('turbolinks:load', function() {
  $(function(){
    function formSetDay(){
      var lastday = formSetLastDay($('#user_birthyear_id option:selected').text(), $('#user_birthmonth_id').val())
      var option = '';
      for (var i = 1; i <= lastday; i++){
        if (i === $('#user_birthday').val()){
          option += '<option value="' + i + '"selected="selected">' + i + '</option>\n';
        }else{
          option += '<option value="' + i + '">' + i + '</option>\n';
        }
      }
      $('#user_birthday').html(option);
    }
    function formSetLastDay(year, month){
      var lastday = new Array("--", 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
      if((year%4 == 0) && (year%100 != 0) || (year%400 == 0)){
        lastday[2] = 29;
        return lastday[month]  
      }else{
        console.log("閏年ではありません")
      return lastday[month]
      }
    }
    $('#user_birthyear_id, #user_birthmonth_id').change(function(){
      formSetDay();
    });
  });
});