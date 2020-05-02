$(function(){

  if(!$("#postcode")[0]) return false;

  let postcode = document.getElementById("postcode");
  let prefecture = document.getElementById("prefecture");
  let city = document.getElementById("city");
  let block = document.getElementById("block");
  let alart_postcode = document.getElementById("alart_postcode");
  let alart_prefecture = document.getElementById("alart_prefecture");
  let alart_city = document.getElementById("alart_city");
  let alart_block = document.getElementById("alart_block");
  
  postcode.addEventListener('blur',function(){
    if(postcode.value == ''){
      alart_postcode.innerHTML = "郵便番号は必須です";
    }
  },false);
  
  prefecture.addEventListener('blur',function(){
    if(prefecture.value == ''){
      alart_prefecture.innerHTML = "都道府県は必須です";
    }
  },false);

  city.addEventListener('blur',function(){
    if(city.value == ''){
      alart_city.innerHTML = "市区町村は必須です";
    }
  },false);

  block.addEventListener('blur',function(){
    if(block.value == ''){
      alart_block.innerHTML = "番地は必須です";
    }
  },false);

});