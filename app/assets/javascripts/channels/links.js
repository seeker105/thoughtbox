$(document).ready(function(){
  var linksInfo = [];
  getLinks();

  $('#linksDiv').on('click', ".unread-button", setRead)
  $('#linksDiv').on('click', ".read-button", setUnRead)
  $('#searchDiv').on('click', ".search", runSearch)
  $('#searchDiv').on('click', ".clear-search", getLinks)
  $('#searchDiv').on('click', ".unread-filter", searchForUnread)
  $('#searchDiv').on('click', ".read-filter", searchForRead)


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
      success: displayResult})
  };

  function displayResult(ajaxData){
    linksInfo = JSON.parse(ajaxData);
    displayLinks(linksInfo);
  }

  function runSearch(){
    var searchString = $("#searchField")[0].value;
    var links = searchBy(searchString);
    displayLinks(links)
  }

  function searchBy(searchTerm){
    return $.grep(linksInfo, function(link, x){
      return link.title.includes(searchTerm);
    });
  }


  function searchForRead(){
    var readLinks = $.grep(linksInfo, function(link, x){
      return link.read === true;
    });
    displayLinks(readLinks);
  }
  
  function searchForUnread(){
    var unreadLinks = $.grep(linksInfo, function(link, x){
      return link.read === false;
    });
    displayLinks(unreadLinks);
  }



  function displayLinks(linksInfo){
    var linksDiv = $("#linksDiv");
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
