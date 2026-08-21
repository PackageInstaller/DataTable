local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local node_count = 8

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_btn_objs = {
    [1] = self.v_uiobjects.Btn1,
    [2] = self.v_uiobjects.Btn2,
    [3] = self.v_uiobjects.Btn3,
    [4] = self.v_uiobjects.Btn4,
    [5] = self.v_uiobjects.Btn5,
    [6] = self.v_uiobjects.Btn6,
    [7] = self.v_uiobjects.Btn7,
    [8] = self.v_uiobjects.Btn8
  }
  self.v_btn_coms = {
    [1] = self.v_uicompents.Btn1_btn,
    [2] = self.v_uicompents.Btn2_btn,
    [3] = self.v_uicompents.Btn3_btn,
    [4] = self.v_uicompents.Btn4_btn,
    [5] = self.v_uicompents.Btn5_btn,
    [6] = self.v_uicompents.Btn6_btn,
    [7] = self.v_uicompents.Btn7_btn,
    [8] = self.v_uicompents.Btn8_btn
  }
  for i = 1, node_count do
    local red = Util.get_child_gameobj("UnLockObj/redpoint", self.v_btn_objs[i].gameObject)
    RedPointMgr:bind_redpoint(self, red, TimeLimitedActMgr:get_red_point_id_list()[i])
  end
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  local is_active = NoviceMgr:get_novice_activity_active(activity_id)
  if is_active then
    self.v_activity_detail_cfg = TimeLimitedActMgr:get_version_activity_detail_cfg()
    if self.v_activity_detail_cfg then
      self:refresh()
    end
  else
    UIMgr:go_to_main()
    return
  end
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
  self:bind_auto_mq(Const.ON_VERSION_ACTIVITY_UPDATE, self.on_version_activity_update, self)
end

function ui:ui_on_hide()
  self:clear_timer()
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id
end

function ui:get_jump_table(type)
  local func = TimeLimitedActMgr:get_btn_jump_fun(type)
  return func
end

function ui:refresh()
  self:clear_timer()
  self.v_timer_list = {}
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = NoviceMgr:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_cfg.OpenTime, activity_cfg.SustainTime)
  self.v_uicompents.Time_txt.text = Date.get_time_format_7(remain_time)
  self:add_timer(0, remain_time, self.v_uicompents.Time_txt)
  for i = 1, node_count do
    local cfg = self.v_activity_detail_cfg[i]
    if cfg then
      if cfg.Type == TimeLimitedActMgr.Type.MainLine then
        local is_open, tips, result3, result4, left_time = TimeLimitedActMgr:is_activity_open(cfg.Id)
        local unlockobj = Util.get_child_gameobj("UnLockObj", self.v_btn_objs[i])
        local lockobj = Util.get_child_gameobj("LockObj", self.v_btn_objs[i])
        local desc_txt = Util.get_text("Desc", lockobj)
        unlockobj:SetActiveEx(is_open)
        if lockobj then
          lockobj:SetActiveEx(not is_open)
        end
        if desc_txt then
          desc_txt.text = tips
        end
        local time_bg = Util.get_child_gameobj("TimeBg", unlockobj)
        local time = Util.get_child_gameobj("Time", unlockobj)
        if time_bg then
          time_bg:SetActiveEx(tips)
        end
        if time then
          time:SetActiveEx(tips)
        end
        self:add_timer(i, left_time, desc_txt)
        self:set_button_listener(self.v_btn_coms[i], function()
          self:on_click_btn(i)
        end)
      else
        local is_open, tips, result3, result4, left_time = TimeLimitedActMgr:is_activity_open(cfg.Id)
        local unlockobj = Util.get_child_gameobj("UnLockObj", self.v_btn_objs[i])
        local lockobj = Util.get_child_gameobj("LockObj", self.v_btn_objs[i])
        unlockobj:SetActiveEx(is_open)
        lockobj:SetActiveEx(not is_open)
        local text
        if is_open then
          text = Util.get_text("Time", unlockobj)
          text.text = tips
        else
          text = Util.get_text("Desc", lockobj)
          text.text = tips
        end
        self:add_timer(i, left_time, text)
        self:set_button_listener(self.v_btn_coms[i], function()
          self:on_click_btn(i)
        end)
      end
    end
  end
end

function ui:add_timer(index, left_time, text)
  if not left_time or left_time <= 0 then
    return
  end
  local timer = Global.ct_timer:add_timer("ui_time_limited_timer" .. index, left_time, function(result_time)
    text.text = Date.get_time_format_7(result_time)
    if result_time <= 0 then
      self:refresh()
    end
  end)
  table.insert(self.v_timer_list, timer)
end

function ui:on_click_btn(node_index)
  local cfg = self.v_activity_detail_cfg[node_index]
  if cfg and cfg.Type == TimeLimitedActMgr.Type.MineSweeper and not Util.get_res_is_integrity() then
    return
  end
  local is_open, tips, is_time_check_fail, open_time_tip = TimeLimitedActMgr:is_activity_open(cfg.Id)
  if is_open then
    self:get_jump_table(cfg.Type)(cfg.Param)
    TimeLimitedActMgr:storage_click_state(cfg.Id)
  elseif is_time_check_fail then
    Util.show_message_tip(open_time_tip .. "解锁")
  else
    Util.show_message_tip(tips)
  end
end

function ui:clear_timer()
  if not self.v_timer_list then
    return
  end
  for _, timer in pairs(self.v_timer_list) do
    if timer then
      Global.ct_timer:remove_timer(timer)
    end
  end
  self.v_timer_list = nil
end

function ui:check_close()
  local is_close = NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
  if not is_close then
    self:refresh()
  end
end

function ui:on_version_activity_update()
  self.v_activity_detail_cfg = TimeLimitedActMgr:get_version_activity_detail_cfg()
  if self.v_activity_detail_cfg then
    self:refresh()
  end
end

return ui
