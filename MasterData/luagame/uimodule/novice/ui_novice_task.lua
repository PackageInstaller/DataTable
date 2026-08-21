local Base = require("ui.uibase")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local TOGGLE_TYPE = {SIGN_IN = 1, TASK = 2}
local ACTIVITY_TYPE = {
  [TOGGLE_TYPE.SIGN_IN] = CommonDef.ACTIVITY_TYPE.NB_SIGN_IN,
  [TOGGLE_TYPE.TASK] = CommonDef.ACTIVITY_TYPE.NB_TASK
}
local GET_STATE = {
  LOCK = 1,
  CAN_SIGN = 2,
  CAN_GET = 3,
  HAS = 4
}

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnReturn2", function()
    self:ui_hide()
  end)
  self.v_tog_list = {}
  local tog_list = {
    [TOGGLE_TYPE.SIGN_IN] = "SignIn",
    [TOGGLE_TYPE.TASK] = "Task"
  }
  for i, v in ipairs(tog_list) do
    if not self.v_tog_list[i] then
      self.v_tog_list[i] = {}
    end
    local tog = self:set_toggle(v, function(isOn)
      self:_on_click_toggle(i, isOn)
    end)
    self.v_tog_list[i] = tog
  end
  local point = self:get_child_gameobj("RedDot", self.v_tog_list[TOGGLE_TYPE.SIGN_IN].gameObject)
  RedPointMgr:bind_redpoint(self, point, RedEnum.NOVICE_SIGN_IN, RedEnum.NOVICE_TASK)
  point = self:get_child_gameobj("RedDot", self.v_tog_list[TOGGLE_TYPE.TASK].gameObject)
  RedPointMgr:bind_redpoint(self, point, RedEnum.NOVICE_DAILY_TASK, RedEnum.NOVICE_TASK)
  self.v_children_panels = {
    [TOGGLE_TYPE.SIGN_IN] = self.v_panels.ui_sign_in_task,
    [TOGGLE_TYPE.TASK] = self.v_panels.ui_daily_task
  }
  self.v_novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
end

function ui:ui_on_show(data, ...)
  local default_type = self:_get_default_type()
  if data and data.tog_type then
    default_type = data.tog_type
  end
  self.v_cur_idx = 0
  self.v_tog_list[default_type].isOn = true
  self:_on_click_toggle(default_type, true)
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_NOVICE_ACTIVE_CLOSE, self.response_activity_close_event, self)
end

function ui:response_activity_close_event(msg)
  if not msg or not msg.mm_x then
    return
  end
  if NoviceMgr:get_sys_open_state() == false then
    self:ui_hide()
  end
end

function ui:ui_on_hide()
  self.v_cur_idx = 0
  for _, v in pairs(self.v_children_panels) do
    v:set_enable(false)
  end
end

function ui:_get_default_type()
  for i = 1, self.v_novice_days do
    local state = NoviceMgr:get_reward_get_state(i)
    if state == GET_STATE.CAN_SIGN or state == GET_STATE.CAN_GET then
      return TOGGLE_TYPE.SIGN_IN
    end
  end
  return TOGGLE_TYPE.TASK
end

function ui:_on_click_toggle(togIdx, isOn)
  if self.v_cur_idx == togIdx then
    return
  end
  if isOn then
    if self.v_children_panels[self.v_cur_idx] then
      self.v_children_panels[self.v_cur_idx]:set_enable(false)
    end
    self.v_cur_idx = togIdx
    self.v_children_panels[self.v_cur_idx]:set_enable(true)
  end
end

return ui
