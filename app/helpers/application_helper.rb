module ApplicationHelper

  def date_select_text(object_name, method, index=nil, js_class='text-input', style_opt="width:100px;")
    if index
      ret = text_field(object_name, method, :index => index, :class => js_class, :style => style_opt)
    else
      ret = text_field(object_name, method, :class => js_class, :style => style_opt)
    end
    ret << load_datepicker("##{object_name.to_s}_#{(index.to_s + "_") if index}#{method}")
    ret.html_safe
  end

  def load_datepicker(selector,holiday_click_flg=false)
    js = <<"EJS"
      $(function() {
  var holidays = {};
  var token = '#{form_authenticity_token}';
  $('#{selector}').datepicker({
    dateFormat: "yy-mm-dd",
    beforeShow: function(input, inst) {
      var date = $(input).datepicker("getDate") || new Date();
      //searchHolidays(date.getFullYear(), date.getMonth()+1);
    },
    onChangeMonthYear: function(year, month, inst) {
      //searchHolidays(year, month);
    },
    beforeShowDay: function(day) {
      var result;
        switch (day.getDay()) {
          case 0: // 日曜日か？
            result = [true, "date-sunday"];
            break;
          case 6: // 土曜日か？
            result = [true, "date-saturday"];
            break;
          default:
            result = [true, ""];
            break;
        }
      return result;
    }
  });
});
EJS
    javascript_tag js
  end
end
