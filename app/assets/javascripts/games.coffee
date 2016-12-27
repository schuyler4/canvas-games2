# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  edit_box = $(".editBox")
  edit_box.hide()

  edit_box_hidden = true

  @show_btn = $("#showBtn")

  #when the edit button is clicked
  @show_btn.click ->
    if edit_box_hidden
      edit_box_hidden = false
      edit_box.show()

    else if !edit_box_hidden
      edit_box_hidden = true
      edit_box.hide()
