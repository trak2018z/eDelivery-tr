
$(document).on 'turbolinks:load', ->
  $('#addpackmodal').on 'show.bs.modal', (event) ->
    button = undefined
    modal = undefined
    recipient = undefined
    button = $(event.relatedTarget)
    no_package = button.attr('data-nopackage')
    modal = $(this)
    return

  $('#add_package').on 'click', (event) ->
    stop = false
    $('.package-data').each ->
      if this.value <= 0
        $(this).css('border-color', 'red');
        stop = true

    if !stop
      package_size = $('#package_size').children()
      packages_container = $('#packages_container')
      clone = package_size.clone()
      addIndexToInputsAndSetReadOnly(clone)
      addLastPackagePriceToOrderPrice()
      packages_container.append clone
      $('#addpackmodal').modal('toggle');
      clearFields()
    return

  $('.package-data').on 'click', (event) ->
    $(this).removeAttr('style')
    return

  $('.package-data').on 'change, input', (event) ->
    $(this).val(parseInt($(this).val()))
    price_box = $('#price_modal')
    package_elem = $('#package_size')
    price = 0
    package_elem.find($('.package-data')).each ->
      price += $(this).val() * $(this).attr('price-for')
    price_box.val("$"+price.toFixed(2))
    return
  return

$(document).on 'click', '.rm-package', ->
  $(this).parent().parent().remove()
  return

clearFields = ->
  $('#package_size').children().find($('.package-data')).each ->
    $(this).val(0)
  $('#price_modal').val('$0.00')
  return

addIndexToInputsAndSetReadOnly = (clone) ->
  number = parseInt($('#new_package').attr("data-nopackage"))+1
  $('#new_package').attr("data-nopackage", number)
  clone.find('.package-data').each ->
    name = $(this).attr('name').replace('[index]', "[no-"+number+"]")
    $(this).attr('name', name)
    $(this).attr("readonly", "readonly")
  setRemoveButtonVisible(clone, number)

setRemoveButtonVisible = (obj, id) ->
  obj.find(('.title-div')).first().attr('hidden', false)


addLastPackagePriceToOrderPrice = ->
  order_price = parseFloat($('#order_price').val().replace('$',''))
  package_price = parseFloat($('#price_modal').val().replace('$',''))
  new_price = order_price+package_price
  $('#order_price').val('$'+new_price.toFixed(2))