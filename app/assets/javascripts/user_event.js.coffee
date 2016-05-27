$ ->

  #userIdを先にロードしてしまう
  userId = $('#user_id').val()

  #出席ボタンクリック
  $('.is_click').on "click", (chkValue) ->
    $btnObj =  $(chkValue.target)
    evId = $btnObj.closest('tr').find('.event_id').val()
    statusId = $btnObj.closest('div').find('.status').val()

    post_data = {"user_id": userId,event_id: evId,status_id: statusId}
    jqXHR = $.ajax({
      type: 'post',
      url: '/user_event/submit_attendance',
      data: post_data,
      dataType: 'json'
    })

    jqXHR.done (data, stat, xhr) ->
#      console.log { done: stat, data: data, xhr: xhr }
      value = data.attendance_type
      text = data.attendance_text
      btn_msg = data.btn_msg
      $btnObj.closest('td').find('.btn').removeClass('btn-primary btn-warning btn-danger')
      $btnObj.addClass(btn_msg)
      $btnObj.closest('tr').find('.attendance').text(text)

    jqXHR.fail (xhr, stat, err) ->
      console.log { fail: stat, error: err, xhr: xhr }
      dhtmlx.alert "更新に失敗しました"#xhr.responseText

  #最初のロード時に色付け
  $(".borderTable tr").each (i,tr) ->
    $dataRow = $(tr).find(".search_status")
    if $dataRow != undefined
      loadStatus = $dataRow.val()
      if loadStatus != "" && loadStatus != undefined
        switch loadStatus
          when "btn-primary"
            $(tr).find('.btn_go').addClass(loadStatus)
          when "btn-warning"
            $(tr).find('.btn_pend').addClass(loadStatus)
          when "btn-danger"
            $(tr).find('.btn_stop').addClass(loadStatus)


