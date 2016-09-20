$(document).ready(function(){
  getLinks();

  $('#linksDiv').on('click', ".unread-button", setRead)
  $('#linksDiv').on('click', ".read-button", setUnRead)

  function setRead(){
    $.ajax({
      method: "PATCH",
      url: "/api/v1/links/" + this.parentElement.id,
      dataType: "JSON",
      data: {link: {read: true}},
      success: getLinks})
  };

  function setUnRead(){
    $.ajax({
      method: "PATCH",
      url: "/api/v1/links/" + this.parentElement.id,
      dataType: "JSON",
      data: {link: {read: false}},
      success: getLinks})
  };

  function getLinks(){
    $.ajax({
      method: "GET",
      url: "/api/v1/links",
      dataType: "text",
      success: displayLinks})
  };

  function displayLinks(ajaxData){
    linksInfo = JSON.parse(ajaxData)
    linksDiv = $("#linksDiv");
    linksDiv.html("");
    linksInfo.forEach(function(link){
      if (link.read === true) {
        var read = "read";
        var buttonText = "Unread"
      } else {
        var read = "unread";
        var buttonText = "Read";
      }
      linksDiv.append('<div class="row link-' + link.id + '" id="' + link.id + '">' + '\
      <button type="button" class="btn btn-default ' + read + '-button">Mark as ' + buttonText + '</button>' + '\
      <a href="edit/' + link.id + '" class="btn btn-default">Edit</a>' +'\
      <a class="link ' + read + '" href="' + link.url_string + '">' + link.title + '</a>');
    });
  }

})
