$(function(){
  var inputs = []
  var list = new DataTransfer();
  var dropZone = document.getElementById("image-box-1");
  var doc = document.querySelector('input[type=file]')

  //loadイベント発生時に発火するイベントを定義
  window.onload = function(e){
    //ドラッグした要素がドロップターゲットの上にある時にイベントが発火
    dropZone.addEventListener("dragover", function(e) {
      //DOMにイベントがたまるのを阻止
      e.stopPropagation();
      //デフォルトイベントをキャンセル
      e.preventDefault();
      //image-box__containerのCSSを変更
      $(this).children('#image-box__container').css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'})
    }, false);
    //ドラッグした要素がドロップターゲットから離れた時に発火するイベント
    dropZone.addEventListener("dragleave", function(e) {
      e.stopPropagation();
      e.preventDefault();
      $(this).children('#image-box__container').css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})
    }, false);
    //ドラッグした要素をドロップした時に発火するイベント
    dropZone.addEventListener("drop", function(e) {
      e.stopPropagation();
      e.preventDefault();
      $(this).children('#image-box__container').css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'});
      //dataTransferで、ドラッグアンドドロップした時にdataTransferオブジェクトを取得
      var files = e.dataTransfer.files;
      //ドラッグアンドドロップで取得したデータについて、プレビューを表示
      $.each(files, function(i,file){
        //アップロードされた画像を元に新しくfilereaderオブジェクトを生成
        var fr = new FileReader();
        //dataTransferオブジェクトに値を追加
        list.items.add(file)
        doc.files = list.files
        //lengthで要素の数を取得
        var num = $('.item-image').length + i + 1
        //指定されたファイルを読み込む
        fr.readAsDataURL(file);
        // 10枚プレビューを出したらドロップボックスが消える
        if (num==10){
          $('#image-box__container').css('display', 'none')   
        }
        //image fileがロードされた時に発火するイベント
        fr.onload = function() {
          //変数srcにresultで取得したfileの内容を代入
          var src = fr.result
          var html =`<div class='item-image' data-image="${file.name}">
                      <div class=' item-image__content'>
                        <div class='item-image__content--icon'>
                          <img src=${src} width="114" height="80" >
                        </div>
                      </div>
                      <div class='item-image__operetion'>
                        <div class='item-image__operetion--delete'>削除</div>
                      </div>
                    </div>`
        //image-box__containerの前にhtmlオブジェクトを追加　
        $('#image-box__container').before(html);
        //配列にhtmlオブジェクトを追加する
        inputs.push(html)
        };
        //image-box__containerにitem-num-(変数)という名前のクラスを追加する
        $('#image-box__container').attr('class', `item-num-${num}`)
      })
    },false);
    //file_fieldが変化した時（image fileがアップロードされた時）
    $(document).on('change','input[type=file]',function(e){
      //file_fieldからfiles属性を取得
      var files = $(this).prop('files')[0];
      $.each(this.files, function(i,file){
        var fr = new FileReader();
        list.items.add(file)
        doc.files = list.files
        var num = $('.item-image').length + 1 + i
        fr.readAsDataURL(file);
        if (num == 10){
          $('#image-box__container').css('display', 'none')   
        }
        fr.onload = function() {
          var src = fr.result
          var html =`<div class='item-image' data-image="${file.name}">
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
        inputs.push(html)
        };
        $('#image-box__container').attr('class', `item-num-${num}`)
      })
    })
    //削除ボタンを押した時に発火するイベント
    $(document).on('click', '.item-image__operetion--delete', function(e) {
      var target_image = $(this).parent().parent()
      var input = doc.files
      var target_name = $(target_image).data('image');
      if (doc.files.length==1){
        $('input[type=file]').val(null)
        list.clearData()
      }  else {
      $.each(input, function(i,inp){
      if (inp.name==target_name){
        list.items.remove(i)
      }
      })
        doc.files = list.files
      }
      target_image.remove()
      var num = $('.item-image').length
      $('#image-box__container').show()
      $('#image-box__container').attr('class', `item-num-${num}`)
    })
  }
})