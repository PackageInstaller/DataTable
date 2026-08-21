local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local mathx = require("base.mathx")
local _min = math.min
local color = {
  5943667,
  16765304,
  16748349,
  15683407
}

function ui:ui_finish_load()
end

function ui:ui_on_show()
  FightDataMgr:start_fight_timer()
  self.v_millisecond_counter = 0
  self:refresh_icon(true)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DEFAULT_TIMER_PAUSE, self.on_fight_default_timer_pause, self)
end

function ui:ui_on_update(dt)
  local fight_time = FightDataMgr:get_use_time()
  if self.v_pre_fight_time ~= fight_time then
    self.v_millisecond_counter = 0
    local index = MineSweeperBattleMgr:get_hp_cost_range_index(fight_time)
    local time_cost_tuple = MineSweeperBattleMgr:get_time_cost_tuple()
    Util.set_color(self.v_uicompents.HpTimeBarFill_img, color[index])
    if index > 1 then
      self.v_uiobjects.TimeNum:SetActiveEx(true)
      Util.change_component_alpha2(self.v_uicompents.HpIcon_img, 0.1)
    else
      self.v_uiobjects.TimeNum:SetActiveEx(false)
      Util.change_component_alpha2(self.v_uicompents.HpIcon_img, 1)
    end
    local hp_cost = time_cost_tuple[index][2]
    self.v_uicompents.TimeNum_txt.text = -hp_cost
    self.v_uicompents.HpNumText_txt.text = "通关后体力-" .. hp_cost
    self.v_pre_fight_time = fight_time
    local count_down_text = self.v_uicompents.TimeNum1_txt
    local remain_hour = math.floor(fight_time / 3600)
    local rest_time = fight_time % 3600
    local remain_min = math.floor(rest_time / 60)
    local remain_sec = rest_time % 60
    if remain_hour > 0 then
      count_down_text.text = string.format("%02d:%02d:%02d", remain_hour, remain_min, remain_sec)
    else
      count_down_text.text = string.format("%02d:%02d", remain_min, remain_sec)
    end
  end
  self.v_millisecond_counter = self.v_millisecond_counter + dt
  self.v_millisecond_counter = _min(1, self.v_millisecond_counter)
  self:hp_update_vfx()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh()
end

function ui:hp_update_vfx()
  local fight_time = FightDataMgr:get_use_time() + self.v_millisecond_counter
  local index = MineSweeperBattleMgr:get_hp_cost_range_index(fight_time)
  local time_cost_tuple = MineSweeperBattleMgr:get_time_cost_tuple()
  if index == #time_cost_tuple then
    self.v_uicompents.HpTimeBarFill_img.fillAmount = 1
  else
    local start_time = time_cost_tuple[index][1]
    local end_time = time_cost_tuple[index + 1][1]
    local range = end_time - start_time
    local ratio = 1 - (fight_time - start_time) / range
    self.v_uicompents.HpTimeBarFill_img.fillAmount = ratio
  end
  Util.set_color(self.v_uicompents.HpTimeBarFill_img, color[index])
  if index > 1 then
    self.v_uiobjects.TimeNum:SetActiveEx(true)
    Util.change_component_alpha2(self.v_uicompents.HpIcon_img, 0.1)
  else
    self.v_uiobjects.TimeNum:SetActiveEx(false)
    Util.change_component_alpha2(self.v_uicompents.HpIcon_img, 1)
  end
end

function ui:refresh_icon(is_pause)
  self.v_uiobjects.TimeRun:SetActiveEx(not is_pause)
  self.v_uiobjects.TimePause:SetActiveEx(is_pause)
end

function ui:on_fight_default_timer_pause(msg)
  if self.v_uiobjects.TimeNum.activeSelf then
    self:refresh_icon(msg.mm_x)
  end
end

return ui
