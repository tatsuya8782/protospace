// File APIを使った処理

$(function(){
  $('.pic').change(function(){
    // console.log(this);
    var index = $('.pic').index(this);
    // console.log(index);
    $('.pic img').eq(index).remove();
    var file = $(this).prop('files')[0];
    if(!file.type.match('image.*')){
      return;
    }
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
      $('.preview').eq(index).html('<img class="resizeimage", src="' + fileReader.result + '"/>');
    }
    fileReader.readAsDataURL(file);
  });
});
