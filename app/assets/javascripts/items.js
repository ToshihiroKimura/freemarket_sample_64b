$(function(){

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

  $('.file').change(function(){
    var file = $('input[type="file"]').prop('files')[0];
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html= `
      <div>
        <img src="${src}">
        <div class="destroy">
          <button type="button">
            削除
          </button>
        </div>
      </div>
      `
      $('.image_box').append(html);
    }
    fileReader.readAsDataURL(file);
  });
});
