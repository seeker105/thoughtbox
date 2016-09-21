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
