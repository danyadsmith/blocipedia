// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

document.jQuery(document).ready(function($) {

selected = $("#new_collaborator:selected").val()
console.log(selected)

$( "#new_collaborator" ).change(function() {
  var add_collaborator = $("#new_collaborator:selected").val();
  var wiki = "<%= j(params['wiki_id']) %>";
  console.log("Collaborator to add: " + add_collaborator)
  console.log("Wiki ID:" + wiki)
});
  
});

