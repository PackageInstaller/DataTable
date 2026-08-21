local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local VERSION_TYPE = {PRE_ACT = 1, LAST_ACT = 2}
local SpineHelper = require("ui.model_rt_view.spine_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SaticSv = require("ui.widget.static_scroll_view")
local COMPENSATE_TASK_ITEM_TEMP_KEY = "COMPENSATE_TASK_ITEM_TEMP_KEY"
local COMPENSATE_TASK_ITEM = require("uimodule.activity.ui_compensate_activity_task_item")
local TASK_STATE = Config.TASK_STATE

function ui:ui_finish_load()
  local activity_id = CompensateMgr:get_compensate_dailyaward_data().activity_id
  self.v_compensate_cfg = ShareRes.get_compensate_cfg(activity_id)
  if self.v_compensate_cfg.PreOrLast == VERSION_TYPE.PRE_ACT then
    self.v_uicompents.Text_txt.text = "上期"
  elseif self.v_compensate_cfg.PreOrLast == VERSION_TYPE.LAST_ACT then
    self.v_uicompents.Text_txt.text = "下期"
  end
  self:set_button("BtnInfo", function()
    if not self.v_compensate_cfg.RuleTextId then
      UIMgr:get_ui("info_tips"):ui_show(2)
    else
      UIMgr:get_ui("info_tips"):ui_show(self.v_compensate_cfg.RuleTextId)
    end
  end)
  self:set_button("BirdSpine", function()
    self:on_click_spine()
    self:animate_spine()
  end)
  self:set_button("DailyAward", function()
    UIMgr:get_ui("cmpnstDailyAwardTip"):ui_show({
      cfg = self.v_compensate_cfg
    })
  end)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.Content, COMPENSATE_TASK_ITEM, COMPENSATE_TASK_ITEM_TEMP_KEY)
  self.v_uicompents.BirdTalkText_txt.text = self.v_compensate_cfg.SpineDesc[1]
end

function ui:ui_on_show()
  self.v_task_group_id = self.v_compensate_cfg.TaskGroupId
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self:clear_spine_rt()
  self.v_spine_id = self.v_compensate_cfg.SpineId
  self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
  self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.BirdSpine)
  SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.BirdSpine)
  self.v_uiobjects.BirdSpine:SetActiveEx(true)
  self.v_show_red_point = false
  self:refresh_task_view()
  self:refresh_dailyaward_view()
  self:refresh_time_remaining()
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:refresh_task_view()
  local task_map = ShareRes.get_task_group(self.v_task_group_id)
  local task_list = UtilTable.map2list(task_map, function(a, b)
    local a_state = TaskMgr:get_task_state(a.Id)
    local b_state = TaskMgr:get_task_state(b.Id)
    local a_priority = a.Priority
    local b_priority = b.Priority
    if a_priority ~= b_priority then
      return a_priority < b_priority
    elseif a_state ~= b_state then
      if a_state == TASK_STATE.GET_REWARD then
        return false
      elseif b_state == TASK_STATE.GET_REWARD then
        return true
      elseif a_state == TASK_STATE.COMPLETE then
        return true
      elseif b_state == TASK_STATE.COMPLETE then
        return false
      end
    elseif a.Id ~= b.Id then
      return a.Id > b.Id
    else
      return false
    end
  end)
  self.v_static_sv:update_list(task_list)
end

function ui:refresh_dailyaward_view()
  self.v_award_item_list = ShareRes.get_awards(self.v_compensate_cfg.AwardGroupId)
  local daily_state = CompensateMgr:get_compensate_dailyaward_data()
  local daily_days = daily_state.gained_day + daily_state.can_gain_day
  if daily_state.gained_day == self.v_compensate_cfg.AwardDayLimit and 0 == daily_state.can_gain_day then
    self.v_uicompents.DayNum_txt.text = "已领取"
  else
    self.v_uicompents.DayNum_txt.text = string.format("%d/%d", daily_days, self.v_compensate_cfg.AwardDayLimit)
  end
  local nextday, finished, can_receive
  if 0 == daily_state.can_gain_day and daily_state.gained_day < self.v_compensate_cfg.AwardDayLimit then
    nextday = true
  end
  if daily_state.can_gain_day > 1 then
    can_receive = true
  elseif 0 == daily_state.can_gain_day and daily_state.gained_day < self.v_compensate_cfg.AwardDayLimit then
    can_receive = false
  elseif daily_state.gained_day == self.v_compensate_cfg.AwardDayLimit then
    finished = true
  elseif 1 == daily_state.can_gain_day then
    can_receive = true
  end
  local daily_redpoint = self.v_uiobjects.DailyAwardRed
  RedPointMgr:bind_redpoint(self, daily_redpoint, RedEnum.COMPENSATE_DAILY_AWARD, RedEnum.COMPENSATE_TASK)
  self.v_show_red_point = can_receive and not nextday and not finished
  RedPointMgr:enable_redpoint(RedEnum.COMPENSATE_DAILY_AWARD, self.v_show_red_point)
  self.v_uiobjects.NextDay:SetActive(nextday)
  self.v_uiobjects.Recive:SetActive(can_receive and not nextday and not finished)
  self.v_uiobjects.Finish:SetActive(finished)
end

function ui:ui_on_hide()
  self.v_static_sv:clear()
  self.v_spine_id = nil
  self:clear_spine_rt()
  UIMgr:try_hide_ui("cmpnstDailyAwardTip")
  UIMgr:try_hide_ui("info_tips")
end

function ui:ui_on_destroy()
  self.v_static_sv = nil
  self:clear_spine_rt()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:animate_spine()
  if self.v_anim_data.record_data.play_start then
    if self.v_anim_data.record_data.play_interrupt then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  else
    SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
  end
end

function ui:on_click_spine()
  self.v_uicompents.BirdTalkText_txt.text = self.v_compensate_cfg.SpineDesc[1]
  local spineDescTable = self.v_compensate_cfg.SpineDesc
  if not spineDescTable or #spineDescTable < 1 then
    warn("[change_SpineDesc] SpineDesc is empty!")
    return
  end
  if not self.lastSpineIndex then
    self.lastSpineIndex = 1
  end
  local availableIndices = {}
  for i, desc in ipairs(spineDescTable) do
    if i ~= self.lastSpineIndex then
      table.insert(availableIndices, i)
    end
  end
  if 0 == #availableIndices then
    warn("[change_SpineDesc] Only one description available!")
    self.lastSpineIndex = 1
  else
    local newIndex = availableIndices[math.random(1, #availableIndices)]
    self.lastSpineIndex = newIndex
  end
  self.v_uicompents.BirdTalkText_txt.text = spineDescTable[self.lastSpineIndex]
end

function ui:refresh_time_remaining()
  self.v_activity_id = self.v_compensate_cfg.ActivityId
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = self.v_parent_panel:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_data.open_time, activity_cfg.SustainTime)
  self.v_uiobjects.Time:SetActive(nil ~= remain_time)
  if nil ~= remain_time then
    self.v_uicompents.Time_txt.text = remain_time
  end
end

return ui
