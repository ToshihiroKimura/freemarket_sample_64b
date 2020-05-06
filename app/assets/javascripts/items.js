$(function(){
 
  // 販売手数料
  $(function () {
    $('#item_price_number').text("ー");
    $('.input-form_price').keyup(function () {
      var number = String($(this).val());
      if ((number >= 300) && (number <= 9999999)) {
        $('#item_price_number').text("¥ " + Math.floor(number * 0.03));
      } else {
        $('#item_price_number').text("ー");
      }
    });
  });
  
  //画面プレビュー
  $('.file').change(function(){
    var file = $('input[type="file"]').prop('files')[0];
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html= `
                  <img class="img" src="${src}">
                  <p>画像を変更する場合はブラウザでページを更新してください</p>
                `
      $('.image_box').append(html);
      $('.item_image_paragraph').hide();
    }
    fileReader.readAsDataURL(file);
  });

  $(function btn_change(){
    $('.add_file').change(function(){
      var file = $('input[type="file"]').prop('files')[0];
      var fileReader = new FileReader();
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `
                    <div class="image_box">
                      <img class="img" src="${src}">
                      <p>もう一度画像を変更する場合はブラウザでページを更新してください</p>
                    </div>
                  `
        $('.img').remove();
        $('.btn_change').remove();
        $('.images_line').append(html);
      }
      fileReader.readAsDataURL(file);
    });
  });
});

