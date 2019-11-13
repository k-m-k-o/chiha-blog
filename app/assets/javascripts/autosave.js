$(document).ready(function(){
  var stack = []
  $(".markdown-input").on("keyup",function(){
    stack.push(1);
    setTimeout(function(){
      stack.pop();
      if (stack.length == 0){
        var body = $("#post_body").val();
        var title = $("#post_title").val();
        var url = location.href
        var matching_template = /\/posts\/[0-9]+\//;
        var picup_num_template = /[0-9]+/
        var processing_url = url.match(matching_template)[0];
        var picked_num = processing_url.match(picup_num_template)[0];

        if (processing_url.length){
          $.ajax({
            type: "post",
            url: "/posts/autosave",
            data: {
              post: {
              title: title,
              body: body,
              category: picked_num
            }},
            beforeSend: function(xhr) {
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            }
        })
          .done(function(data){
            $(".new-post__right__preview").html(data);
            $(".markdown-container").animate({scrollTop: $(".markdown-container")[0].scrollHeight},"fast");
          });
        }
      }
    },3000);
  })
});