$(document).on 'show.bs.modal', '.ar-modal', ->
  $(this).find($('.select2-select')).each ->
    $(this).select2
      dropdownParent: $('.ar-modal')
      theme: 'bootstrap'
      allowClear: true
      placeholder: $(this).attr('placeholder')
  return