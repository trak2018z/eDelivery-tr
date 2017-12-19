//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require toastr
//= require bootstrap-slider
//= require select2
//= require moment
//= require_tree .

$(document).on("ajax:error", "form", function(evt) {
    var errors = evt.detail[0].errors;
    var prefix = evt.detail[0].prefix;
    console.log(evt.detail[0])
    for (m in errors) {
        input = $('.ar-modal.show, .form-with-errors').find($('#'+prefix+m));
        if(input.parent().hasClass('input-group')){
            parent = input.parent().parent();
            error_box = parent.find('.field_with_errors')}
        else{
            parent = input.parent();
            error_box = parent.find('.field_with_errors')}
        error_box.text(errors[m][0].substr(0,1).toUpperCase()+errors[m][0].substr(1)+'.')
        parent.addClass('has-error');
    }
});

$(document).on('click', '.confirm-delete', function(event){
    $('#confirm-delete').modal('show').find('form').attr('action', $(this).attr('data-href'));
});

$(document).on('turbolinks:load', function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
});


$(document).on('focus', '.form-control', function() {
    input = $(this);
    parent = input.parent();
    if (parent.hasClass('input-group'))
        parent = input.parent().parent();
    parent.removeClass('has-error');
    parent.find($('.field_with_errors')).html('')
});

$(document).on('select2:opening', '.select2-select', function() {
    $(this).parent().removeClass('has-error');
    $(this).parent().find($('.field_with_errors')).html('')
    if ($(this).val().length > 0) {
        var label = $(this).parent().find($('label'));
        label.addClass('visible');
    }
});

$(document).on('select2:closing', '.select2-select', function() {
    var label = $(this).parent().find($('label'));
    label.removeClass('visible');
});

$(document).on('input focus', '.form-control', function(event) {
    var label = $("label[for='"+event.currentTarget.attributes.id.value+"']");
    var len = $(this).val().length;
    if (len > 0) label.addClass('visible'); else label.removeClass('visible');
});

$(document).on('focusout', '.form-control', function(event) {
    var label = $("label[for='"+event.currentTarget.attributes.id.value+"']")
    label.removeClass('visible');
});
