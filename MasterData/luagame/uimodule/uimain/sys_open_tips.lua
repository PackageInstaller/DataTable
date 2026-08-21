local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_sys_name = {
    "TipsCont",
    BIND_TYPE.TEXT
  }
}
local SYS_ICON_PATH = "UIMain/Warn/%s"
local type_playable_director = typeof(UnityEngine.Playables.PlayableDirector)

function ui:ui_finish_load(...)
  self.v_show_pd = self.v_uiobjects.ShowPd:GetComponent(type_playable_director)
  self:init_model(MODEL)
  self:set_button("ReturnBg", function()
    self:_onclick_close_btn()
  end)
  self.v_showing = false
  self.v_canvas_group = self:get_canvas_group(nil, self.v_uiobjects.Tips)
end

function ui:ui_on_show(...)
  if self.v_showing == true then
    return
  end
  self.v_showing = false
  self.v_queue = SysOpenMgr:get_open_queue()
  self:_set_data()
end

function ui:ui_on_hide()
  self.v_showing = false
  if self.v_Sequence then
    self.v_Sequence:Kill(false)
    self.v_Sequence = nil
  end
end

function ui:response_sys_open_event(msg)
  self.v_queue = SysOpenMgr:get_open_queue()
  self:_set_data()
end

function ui:_set_data(last_timer)
  if next(self.v_queue) == nil then
    self:ui_hide()
    return
  end
  local data = self.v_queue[1]
  table.remove(self.v_queue, 1)
  self.v_canvas_group.alpha = 0
  if data.Icon ~= "" then
  end
  self.v_sys_name.text = data.Name
  if self.v_Sequence then
    self.v_Sequence:Kill(false)
    self.v_Sequence = nil
  end
  self.v_Sequence = Util.create_sequence()
  local timer = last_timer
  local duration = self.v_show_pd.duration
  self.v_show_pd:Play()
  self.v_canvas_group.alpha = 1
  self.v_Sequence:AppendInterval(duration)
  self.v_Sequence:AppendCallback(function()
    self.v_canvas_group.alpha = 0
    self.v_show_pd:Stop()
    self:_set_data(timer)
  end)
end

function ui:_onclick_close_btn()
  self.v_show_pd:Stop()
  if next(self.v_queue) == nil then
    self:ui_hide()
  else
    self:_set_data()
  end
end

return ui
