//カテゴリー プルダウンメニュー
$(function () {
  $('.category_list').hover(function() {
    var category_obj = $(this).children('.parent_top');
    category_obj.show();
  }, function() {
    $(this).children('.parent_top').hide();
  });

  $('.parent_list').hover(function() {
    var category_obj = $(this).children('.child_top');
    category_obj.show();
  }, function() {
    $(this).children('.child_top').hide();
  });

  $('.child_list').hover(function() {
    var category_obj = $(this).children('.grandchild_top');
    category_obj.show();
  }, function() {
    $(this).children('.grandchild_top').hide();
  });
});

// ブランド プルダウンメニュー
$(function () {
  $('.brand_list').hover(function () {
    var brand_obj = $(this).children('.brand-menu');
    brand_obj.show();
  }, function () {
    $(this).children('.brand-menu').hide();
  });
});