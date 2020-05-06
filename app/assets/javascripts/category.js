$(function(){
  //カテゴリーフォームにオプション追加
  function appendOption(category){
    var html = `<option value="${category.id}"data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  //子要素のHTML
  function createChildrenBox(addHTML){
    var childHTML ='';
     childHTML= `<div class=item-category-form id="children-form-box">
                  <select class="input-select" id="children-form" name="item[category_id]">
                    <option value="---" data-category="---">選択してください</option>
                      ${addHTML}
                  </div>
                </div>`;

    $('.item_category').append(childHTML);
  }
  //孫要素のHTML
  function createGrandchildrenBox(addHTML){
    var grandchildrenHTML ='';
    grandchildrenHTML= `<div class=item-category-form id="grandchildren-form-box" >
                          <select class="input-select" id="grandchildren-form" name='item[category_id]'>
                            <option value="---" data-category="---">選択してください</option>
                              ${addHTML}
                          </div>
                        </div>`;

    $('.item_category').append(grandchildrenHTML);
  }

    //親カテゴリーを選択したら発火
    $('#parent-form').on('change',function(){
      var parentCategory = document.getElementById('parent-form').value;
      if (parentCategory !=""){
        $.ajax({
          url: '/items/category_children',
          type: 'GET',
          data: {parent_name: parentCategory},
          dataType: 'json'
        })
        .done(function(children){
          $('#children-form').remove();
          $('#grandchildren-form').remove();

          var addHTML ='';
          children.forEach(function(child){
            addHTML += appendOption(child);
          });
          createChildrenBox(addHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children-form').remove();
        $('#grandchildren-form').remove();
      }
    })
    //子カテゴリーを選択したら発火
    $('.item_category').on('change','#children-form',function(){
      var childCategoryId = $('#children-form option:selected').data('category');
      if (childCategoryId !="---"){
        $.ajax({
          url: '/items/category_grandchildren',
          type: 'GET',
          data: {child_name: childCategoryId},
          dataType: 'json'
        })
          .done(function(grandchildren){
            $('#grandchildren-form').remove(); 
            var addHTML ='';
            grandchildren.forEach(function(grandchild){
              addHTML += appendOption(grandchild);
            })
            createGrandchildrenBox(addHTML);
          })
          .fail(function(){
            alert('カテゴリー取得に失敗しました');
          })
      }else{
        $('#grandchildren-form').remove();
      }
    });
});

