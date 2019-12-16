//turbolinksのキャンセル
$(document).on('turbolinks:load', function() {
  var form = $("#card_form");
  //パブリックキーを設定
  Payjp.setPublicKey('pk_test_f63e5ae958d7285ca653c370');
  //submitを押した時に、イベントを発火させる
  $(document).on("click", "#token_submit", function(e) {
    //railsサーバーにデフォルトで送信されるのをキャンセルする
    e.preventDefault();
    //id="card_form"のあるタグについて、ボタンを無効にする
    form.find("input[type=submit]").prop("disabled", true);
    //form要素のvalueを取り出す
    var card = {
        number: $("#card_number").val(),
        cvc: $("#card_cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val(),
    };
    //Payjp.createTokenメソッドを使って、トークンを作成。referencesを参照。
    Payjp.createToken(card, function(s, response) {
      //responseエラーが起こった場合のエラーメッセージ
      if (response.error) {
        alert('トークン作成エラー発生');
      }
      //エラーが起こらなかった場合
      else {
        //name属性を削除し、データベースに保存されないようにする
        $("#card_number").removeAttr("name");
        $("#card_cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        //変数tokenにpayjpから返ってきた情報を格納する
        var token = response.id;
        //formにinputタグを追加。hidden_fieldでpayjpTokenを送る
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        //index番号0を指定してsubmitを実行。railsのcontrollerへ！
        form.get(0).submit();
      }
    });
  });
});