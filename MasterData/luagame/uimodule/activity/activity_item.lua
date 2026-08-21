local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_on_hide()
  if self.v_data and self.v_data.ui_name then
    UIMgr:try_hide_ui(self.v_data.ui_name)
  end
end

function ui:set_data(index, data, time_limit)
  self.v_index = index
  self.v_data = data
  self.v_time_limit = time_limit
  ResMgr:load_set_icon(self.v_uicompents.PageIcon_img, data.page_bg)
  self.v_tog = self:get_toggle().component
  self:refresh()
end

function ui:update_page_bg(path)
  if path then
    self.v_data.page_bg = path
    ResMgr:load_set_icon(self.v_uicompents.PageIcon_img, path)
  end
end

function ui:refresh()
  if self.v_data.redpoint then
    RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedPoint, self.v_data.redpoint)
  else
    self.v_uiobjects.RedPoint:SetActive(false)
  end
  self.v_uicompents.TimeLimitText_txt.text = self.v_time_limit
  self.v_uiobjects.TimeLimit:SetActive(self.v_time_limit ~= nil)
  local activity_ui = UIMgr:try_get_visible_ui(self.v_data.ui_name)
  if activity_ui and activity_ui.refresh then
    activity_ui:refresh()
  end
end

function ui:refresh_time_limit()
  if not (self.v_data and self.v_data.time_type) or not self.v_data.open_time then
    return
  end
  self.v_uicompents.TimeLimitText_txt.text = self.v_parent_ui:get_time_remaining(self.v_data.time_type, self.v_data.stop_time, self.v_data.open_time, self.v_data.sustain_time)
end

function ui:on_select_state_change(is_select, activity_id, sub_param)
  if is_select then
    self:play_playable_director("OnSelect")
  else
    self:stop_playable_director("OnSelect", true)
  end
  self.v_is_select = is_select
  self.v_uiobjects.UnselectMask:SetActive(not is_select)
  self.v_uiobjects.Unselect:SetActive(not is_select)
  self.v_uiobjects.Select:SetActive(is_select)
  self:set_activity_ui_show(is_select, activity_id, sub_param)
end

function ui:set_activity_ui_show(is_select, activity_id, sub_param)
  if not Util.is_empty(self.v_data.ui_name) then
    local activity_ui
    if is_select then
      activity_ui = UIMgr:get_ui(self.v_data.ui_name)
      activity_ui:ui_show(activity_id, sub_param)
    else
      UIMgr:try_hide_ui(self.v_data.ui_name)
    end
  end
end

function ui:set_is_on(is_on)
  self.v_tog.isOn = is_on
end

return ui
