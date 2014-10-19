UserTable = (options) ->
  this.init options

UserTable.prototype = {
  id: null,
  data: null,
  action: null,
  $table: null,
  $template: null,

  init: (options) ->
    self = this
    self.id = options.id
    self.data = {}
    self.action = options.action
    self.$table = $("##{self.id}")
    self.$template = self.$table.find('.template').clone().removeClass('template')
    self.$table.find('.template').remove()
    rows = $.parseJSON $("##{self.id}_json").text()
    $.each rows, (i, row) -> self.add_row row
    self

  add_row: (data) ->
    this.data[data.id] = data
    $row = this.$template.clone()
    $row.attr('id', "#{this.id}-row-#{data.id}")
    $row.data('id', data.id)
    $row.find('.data_id').val(data.id)
    $row.find('.user_name').text(data.user.name)
    $row.find('.leader_id').val(data.id).attr('id', "leader_id_radio-#{data.id}")
    $.each data.answers, (i, answer) ->
      $row.find(".answer-#{i}").text(answer)
    $row.find('.action').click(this.action)
    this.$table.append $row

  remove_row: (data_id) ->
    data = this.data[data_id]
    delete this.data[data_id]
    $("##{this.id}-row-#{data_id}").remove()
    data
}

group_users = unassigned_users = null

$ ->
  group_users = new UserTable({ id: 'group_users', action: unassign_user })
  leader_id = group_users.$table.data('leader-id')
  $("#leader_id_radio-#{leader_id}").attr('checked', true) if leader_id

  unassigned_users = new UserTable({ id: 'unassigned_users', action: assign_user })

assign_user = ->
  id = $(this).closest('.row').data('id')
  data = unassigned_users.remove_row(id)
  group_users.add_row(data)

unassign_user = ->
  id = $(this).closest('.row').data('id')
  data = group_users.remove_row(id)
  unassigned_users.add_row(data)
