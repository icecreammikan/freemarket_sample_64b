document.addEventListener("turbolinks:load", function(){
  $(function() {
    var password  = '#registration-password__input';
    var passcheck = '#password_checkbox';

    $(passcheck).change(function() {
        if ($(this).prop('checked')) {
            $(password).attr('type','text');
        } else {
            $(password).attr('type','password');
        }
    });
  });
});