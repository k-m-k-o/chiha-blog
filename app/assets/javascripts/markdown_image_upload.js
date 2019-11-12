$(document).ready(function(){
  $('.uploadable').inlineattachment({
    urlText: "![]({filename})",
    uploadUrl: "/assets",
    uploadFieldName: "asset[file]",
    allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
    extraHeaders: {"X-CSRF-Token": $("meta[name=csrf-token]").attr("content")}
  });
});