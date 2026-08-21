local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LoopListClass = require("ui.widget.infinite_loop_list")
local TaskItemClass = require("uimodule.activity.fish_game.fish_game_task_item")
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
local _tinsert = table.insert
local TASK_STATE_PRO = {
  [TASK_STATE.COMPLETE] = 1,
  [TASK_STATE.CAN_RECEIVE] = 2,
  [TASK_STATE.NOT_RECEIVE] = 3,
  [TASK_STATE.RECEIVE] = 4,
  [TASK_STATE.GET_REWARD] = 5
}

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnRetX", function()
    self:ui_hide()
  end)
  self:set_button("BtnAllGet", function()
    self:get_cpl_task_list()
    TaskMgr:submit_task_list(self.v_task_cpl)
    self.v_uiobjects.AllGot:SetActive(true)
    self.v_uiobjects.BtnAllGet:SetActive(false)
  end)
  self.v_task_view = LoopListClass:new(self, self.v_uiobjects.CtList, TaskItemClass)
end

function ui:ui_on_show(data)
  self:refresh_task()
  self.v_task_view:refresh_data(self.v_hold_task_data)
  self.v_task_cpl = {}
  self:bind_auto_mq(Const.ON_RET_ACT_SIGN_AWARD, self.refresh_show_by_task, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_show_by_task, self)
end

function ui:refresh_show_by_task()
  self:refresh_task()
  self.v_task_view:refresh_data(self.v_hold_task_data)
  local red_show = NoviceMgr:get_fish_game_has_red()
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_ACTIVITY_BTN_1, red_show)
end

function ui:refresh_task()
  local ACT_ID = NoviceMgr:get_fish_game_act_id()
  local cfg = ShareRes.get_fish_game_fish_game_cfg(ACT_ID)
  local hold_data_map = ShareRes.get_task_group(cfg.TaskGroupId)
  self.v_hold_task_data = UtilTable.map2list(hold_data_map, function(a, b)
    local task_state_a = TaskMgr:get_task_state(a.Id)
    local task_state_b = TaskMgr:get_task_state(b.Id)
    local task_state_a_pro = TASK_STATE_PRO[task_state_a] or 0
    local task_state_b_pro = TASK_STATE_PRO[task_state_b] or 0
    local a_priority = a.Priority
    local b_priority = b.Priority
    if task_state_a_pro ~= task_state_b_pro then
      return task_state_a_pro < task_state_b_pro
    elseif a_priority ~= b_priority then
      return a_priority < b_priority
    elseif a.Id ~= b.Id then
      return a.Id < b.Id
    else
      return false
    end
  end)
  self:get_cpl_task_list()
  if next(self.v_task_cpl) ~= nil then
    self.v_uiobjects.AllGot:SetActive(false)
    self.v_uiobjects.BtnAllGet:SetActive(true)
  else
    self.v_uiobjects.AllGot:SetActive(true)
    self.v_uiobjects.BtnAllGet:SetActive(false)
  end
end

function ui:get_cpl_task_list()
  self.v_task_cpl = {}
  for _, data in pairs(self.v_hold_task_data) do
    local task_id = data.Id
    local task_state = TaskMgr:get_task_state(task_id)
    if task_state == TASK_STATE.COMPLETE then
      _tinsert(self.v_task_cpl, task_id)
    end
  end
end

function ui:ui_on_hide()
  self.v_task_view:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_task_view:ui_on_destroy()
end

return ui
