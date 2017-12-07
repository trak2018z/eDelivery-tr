
$(document).on 'turbolinks:load', ->

  $('#add_package').on 'click', (event) ->
    package_size_fields = $('#package_size').children()
    if checkIfAllFieldsContainsData(package_size_fields)
      packages_container = $('#packages_container')
      clone = package_size_fields.clone()
      addIndexToInputsAndSetReadOnly(clone)
      addLastPackagePriceToOrderPrice()
      packages_container.append clone
      $('.ar-modal').modal('toggle');
      clearFields()
    return

  $('#package_size input').on 'change, input', (event) ->
    price = 0
    $(this).parent().find($('input')).each ->
      price += $(this).val() * $(this).attr('price-for')
    $('#price_modal').val(price.toFixed(2))
    return
  return

# for elemenets created after script bind
$(document).on 'click', '.rm-package', ->
  $(this).parent().parent().remove()
  return

# helpers
checkIfAllFieldsContainsData = (package_size_fields) ->
  containsData = true
  package_size_fields.find($('input')).each ->
    if this.value <= 0
      $(this).css('border-color', 'red');
      containsData = 0 # false breaking loop
  return containsData

clearFields = ->
  $('#package_size').children().find($('.package-data')).each ->
    $(this).val(0)
  $('#price_modal').val('0.00')
  return

addIndexToInputsAndSetReadOnly = (clone) ->
  number = parseInt($('#new_package').attr("data-nopackage"))+1
  $('#new_package').attr("data-nopackage", number)
  clone.find('input').each ->
    name = $(this).attr('name').replace('[index]', "[no-"+number+"]")
    $(this).attr('name', name)
    $(this).attr("readonly", "readonly")
  setRemoveButtonVisible(clone, number)

setRemoveButtonVisible = (obj, id) ->
  obj.find(('.title-div')).first().attr('hidden', false)

addLastPackagePriceToOrderPrice = ->
  order_price = parseFloat($('#order_price').val())
  package_price = parseFloat($('#price_modal').val())
  $('#order_price').val((order_price+package_price).toFixed(2))