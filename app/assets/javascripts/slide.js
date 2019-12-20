$(document).on('turbolinks:load', function() {
  $(function(){
    $('.slider').slick({
      //アクセシビリティで、左右のボタンで画像切り替え出来るかどうか
      accesibility: true,
      //画面下にドットの表示
      dots: true,
      //自動再生をする
      autoplay: true,
      //自動切り替えをする時間
      autoplayspeed: 7000,
    });
  });
});