//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require toastr
//= require bootstrap-slider
//= require select2
//= require_tree .


$(document).on("ajax:error", "form", function(evt) {
    var errors = evt.detail[0].errors;
    var prefix = evt.detail[0].prefix;
    console.log(evt.detail[0])
    for (m in errors) {
        input = $('.ar-modal.show').find($('#'+prefix+m));
        error_box = input.parent().find('.field_with_errors');
        error_box.text(errors[m][0].substr(0,1).toUpperCase()+errors[m][0].substr(1)+'.')
        if (input.hasClass('select2_select'))
            input.parent().addClass('has-error');
        input.parent().addClass('has-error')
    }
});

$(document).on('turbolinks:load', function() {
    $('.confirm-delete').on('click', function(event){
        $('#confirm-delete').modal('show').find('form').attr('action', $(this).attr('data-href'));
    });
});


$(document).on('focus', '.form-control', function() {
    $(this).parent().removeClass('has-error');
    $(this).parent().find($('.field_with_errors')).html('')
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
    var label = $(this).parent().find($('label'));
    var len = $(this).val().length;
    if (len > 0) label.addClass('visible'); else label.removeClass('visible');
});

$(document).on('focusout', '.form-control', function(event) {
    var label = $(this).parent().find($('label'));
    label.removeClass('visible');
});
