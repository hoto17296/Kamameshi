$ ->
  is_participant = parseInt $('#user_group_is_participant').val()
  $('.is_participant button').each ->
    if $(this).data('value') == is_participant
      $(this).removeClass('btn-default').addClass('btn-success')

  $('.is_participant button').click ->
    $('#user_group_is_participant').val $(this).data('value')
    $(this).removeClass('btn-default').addClass('btn-success')
    $(this).siblings('button').removeClass('btn-success').addClass('btn-default')
