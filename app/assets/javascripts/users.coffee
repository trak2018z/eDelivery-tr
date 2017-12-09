$(document).on 'show.bs.modal', '.ar-modal', ->
  $(this).find($('.select2-select')).each ->
    $(this).select2
      dropdownParent: $('.ar-modal')
      theme: 'bootstrap'
      allowClear: true
      placeholder: $(this).attr('placeholder')
  return

$ ->
  $("a").bind "ajax:error", (event, jqXHR, ajaxSettings, thrownError) ->
    if jqXHR.status == 401 # thrownError is 'Unauthorized'
      window.location.replace('/users/sign_in')