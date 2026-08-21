local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button_listener(nil, function()
    if self.temp_data_tag then
      self.v_parent_ui:on_select_change(self)
    else
      self.static_scroll_view:on_select_change(self)
    end
  end)
end

function ui:ui_on_show()
  self:clear_timer()
end

function ui:ui_on_hide()
  self:clear_timer()
end

function ui:ui_on_destroy()
end

function ui:set_data(data)
  self.file_id = data.id
  self.file_disable_time = data.expire_time
  self.index = data.index
  self:set_name(data.name)
  if self.v_parent_ui:is_select_limit_time_file() and Util.is_more_than_zero(self.file_disable_time) then
    local remain_time = self.file_disable_time - Date.server_time()
    if remain_time > 0 and remain_time < 3600 then
      self:clear_timer()
      self.v_timer = Global.ct_timer:add_timer(nil, remain_time + 60, self.timer_refresh_time_limit, self)
    end
  end
  self:self_refresh_time_limit()
end

function ui:set_name(name)
  self.file_name = name
  self.v_uicompents.FileName1_txt.text = self.file_name
  self.v_uicompents.FileName2_txt.text = self.file_name
end

function ui.refresh_time_limit(_, self)
  local is_limit_time = self.v_parent_ui:is_select_limit_time_file()
  if is_limit_time then
    local has_disavle_time = Util.is_more_than_zero(self.file_disable_time)
    self.v_uiobjects.Time1:SetActive(has_disavle_time)
    self.v_uiobjects.Time2:SetActive(has_disavle_time)
    if has_disavle_time then
      local remain_time = self.file_disable_time - Date.server_time()
      local str = Date.get_time_formate_2(remain_time)
      self.v_uicompents.TimeNum1_txt.text = str
      self.v_uicompents.TimeNum2_txt.text = str
    end
  else
    self.v_uiobjects.Time1:SetActive(false)
    self.v_uiobjects.Time2:SetActive(false)
  end
end

function ui:self_refresh_time_limit()
  self.refresh_time_limit(nil, self)
end

function ui.timer_refresh_time_limit(_, self)
  if not self.v_parent_ui or self.v_parent_ui:visible() then
    self:clear_timer()
    return
  end
  self.refresh_time_limit(_, self)
  if self.v_is_select then
    if self.file_disable_time <= Date.server_time() then
      self.v_parent_ui:refresh_view()
    else
      self.v_parent_ui:refresh_time_limit(self.file_disable_time)
    end
  end
end

function ui:set_temp_data_tag(tag)
  self.temp_data_tag = tag
end

function ui:get_temp_data_tag()
  return self.temp_data_tag
end

function ui:set_selected(is_select)
  self.v_is_select = is_select
  self.v_uiobjects.Normal:SetActive(not is_select)
  self.v_uiobjects.Select:SetActive(is_select)
end

function ui:on_clear()
end

function ui:clear_timer()
  if self.v_timer then
    Global.ct_timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

return ui
