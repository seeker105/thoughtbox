$(document).ready(function(){
  var linksInfo = [];
  getLinks();

  $('#linksDiv').on('click', ".unread-button", setRead)
  $('#linksDiv').on('click', ".read-button", setUnRead)
  $('#searchDiv').on('click', ".search", runSearch)
  $('#searchDiv').on('click', ".clear-search", getLinks)
  $('#searchDiv').on('click', ".unread-filter", {term: false}, searchForRead)
  $('#searchDiv').on('click', ".read-filter", {term: true}, searchForRead)
  $('#searchDiv').on('click', ".alphabetical-sort", alphaSort)


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

  function searchForRead(input){
    var status = input.data.term
    var filteredLinks = $.grep(linksInfo, function(link, x){
      return link.read === status;
    });
    displayLinks(filteredLinks);
  }

  function alphaSort(){
    var sorted = linksInfo.sort(function(a, b){
      if (a.title < b.title) {
        return -1;
      };
      if (a.title > b.title) {
        return 1;
      }
      return 0;
    });
    displayLinks(sorted);
  }
})
