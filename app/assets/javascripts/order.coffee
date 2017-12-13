$(document).on 'turbolinks:load', ->

  $('#prefered_receipt_date').datetimepicker
    useCurrent: false
    format: "DD/MM/YYYY"
    orientation: "left"
  $('#prefered_delivery_date').datetimepicker
    useCurrent: false
    format: "DD/MM/YYYY"
  $('#prefered_receipt_date').on 'change.datetimepicker', (e) ->
    $('#prefered_delivery_date').datetimepicker 'minDate', e.date
    return
  $('#prefered_delivery_date').on 'change.datetimepicker', (e) ->
    $('#prefered_receipt_date').datetimepicker 'maxDate', e.date
    return

  $ ->
    $(this).find($('.select2-select')).each ->
      $(this).select2
        width: '100%'
        theme: 'bootstrap'
        allowClear: true
        templateResult: (data, container) ->
          if data.element
            $(container).addClass $(data.element).attr('class')
          data.text
        placeholder: $(this).attr('placeholder')
    return

  $('#new_package').click (e) ->
    $(this).attr('disabled', 'disabled').css('width',$(this).outerWidth()).html("<i class='fa fa-spinner fa-pulse fa fa-fw'></i>")
    $.ajax('/packages/new')
    return

  ## Package modal
$(document).on 'show.bs.modal', '.ar-modal', ->
  $('.modal-body input').on 'change, input', (event) ->
    price = 0
    container = $('.modal-body')
    container.find($('input')).each ->
      price += $(this).val() * $(this).attr('pricefor')
    $('.price_modal').val(price.toFixed(2))
    return

  $('#prefered_receipt_date').datetimepicker
    useCurrent: false
    format: "DD/MM/YYYY"
    orientation: "left"
  $('#prefered_delivery_date').datetimepicker
    useCurrent: false
    format: "DD/MM/YYYY"
  $('#prefered_receipt_date').on 'change.datetimepicker', (e) ->
    $('#prefered_delivery_date').datetimepicker 'minDate', e.date
    return
  $('#prefered_delivery_date').on 'change.datetimepicker', (e) ->
    $('#prefered_receipt_date').datetimepicker 'maxDate', e.date
    return
  return

$(document).on 'click', '.rm-package', ->
  pack_container = $(this).parent().parent().parent()
  pack_price = parseFloat(pack_container.find($('input[id=price_modal]')).val())
  order_price = parseFloat($('#order_price').val())
  $('#order_price').val((order_price-pack_price).toFixed(2))
  pack_container.remove()
  return


$(document).on 'select2:selecting', '.select2-select', (e) ->
  data = e.params.args.data;
  if(data.id == 'Add address')
    e.preventDefault();
    $(this).select2('close');
    window.address_input = this.id
    $.ajax('/addresses/new')
  return
