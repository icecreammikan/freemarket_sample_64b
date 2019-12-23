$(document).on("turbolinks:load", function() {
  if(document.URL.match(/edit/)){
    var dataBox = new DataTransfer()
    var file_field = document.querySelector('input[type=file]')
    var dropArea = document.getElementById("image-box-1");
      
    gon.images.forEach(function(image, index){
      var src = image.image_url.url　
      var num = $('.item-image').length + 1
      var html =`<div class='item-image' data-image="${num}">
                  <div class=' item-image__content'>
                    <div class='item-image__content--icon'>
                      <img src=${src} width="114" height="80" >
                    </div>
                  </div>
                  <div class='item-image__operetion'>
                    <div class='item-image__operetion--delete'>削除</div>
                  </div>
                </div>`
      $('#image-box__container').before(html);
      $('#image-box__container').attr('class', `item-num-${num}`)
    })
  }
})