local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CT_Timer = Global.ct_timer
local RETURN_ACTIVITY = {
  SIGN_ACT = "ui_return_activity_sign",
  TASK_ACT = "ui_return_activity_task",
  GIFT_ACT = "ui_return_activity_gift",
  NEW_CNT_ACT = "ui_return_activity_new"
}
local RETURN_ACTIVITY_CFG_ID = {
  SIGN_ACT = 1,
  TASK_ACT = 2,
  GIFT_ACT = 3,
  NEW_CNT_ACT = 4
}
local RET_ACT_SIGN_TOTAL_DAYS = 7

function ui:ui_finish_load()
  self.v_sgin_num1 = Util.get_text("SignAwardBg/SignNum1", self.v_uiobjects.Activity1Btn)
  self.v_sgin_num2 = Util.get_text("SignAwardBg/SignNum2", self.v_uiobjects.Activity1Btn)
  self.v_sgin_red_dot = Util.get_child_gameobj("RedDot", self.v_uiobjects.Activity1Btn)
  self.v_gift_red_dot = Util.get_child_gameobj("RedDot", self.v_uiobjects.Activity3Btn)
  self.v_gift_red_dot:SetActive(false)
  self.v_task_num1 = Util.get_text("TaskAwardBg/TaskNum1", self.v_uiobjects.Activity2Btn)
  self.v_task_num2 = Util.get_text("TaskAwardBg/TaskNum2", self.v_uiobjects.Activity2Btn)
  self.v_task_red_dot = Util.get_child_gameobj("RedDot", self.v_uiobjects.Activity2Btn)
  self.v_new_red_dot = Util.get_child_gameobj("RedDot", self.v_uiobjects.Activity4Btn)
  self:set_button("Activity1Btn", function()
    local activity_ui = UIMgr:get_ui(RETURN_ACTIVITY.SIGN_ACT)
    activity_ui:ui_show(self)
  end)
  self:set_button("Activity2Btn", function()
    local activity_ui = UIMgr:get_ui(RETURN_ACTIVITY.TASK_ACT)
    activity_ui:ui_show()
  end)
  self:set_button("Activity3Btn", function()
    RechargeMgr:request_product_info(function()
      local activity_ui = UIMgr:get_ui(RETURN_ACTIVITY.GIFT_ACT)
      activity_ui:ui_show()
    end)
  end)
  self.v_act_new_img = Util.get_image(nil, self.v_uiobjects.Activity4Btn)
end

function ui:check_time_condition(start_time_param, end_time_param)
  local cur_time = Date.server_time()
  local start_time = start_time_param and Date.get_time_stamp_by_scheme_id(start_time_param)
  if start_time and cur_time < start_time then
    return false
  end
  local end_time = end_time_param and Date.get_time_stamp_by_scheme_id(end_time_param)
  if end_time and cur_time > end_time then
    return false
  end
  return true
end

function ui:ui_on_show(id, polt_id)
  self.v_ret_act_info = NoviceMgr:get_activity_flyback_info()
  self.v_end_time = self.v_ret_act_info.end_time
  self:refresh_red()
  self:refresh_show_time()
  if not UIMgr:try_get_visible_ui("uistory") then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_return_activity_main_in_UI_SOUND)
  end
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.refresh_red, self)
  self:bind_auto_mq(Const.ON_RET_ACT_SIGN_AWARD, self.refresh_red, self)
  local cfg_main_view = ShareRes.get_return_activity_main_view_cfg(RETURN_ACTIVITY_CFG_ID.NEW_CNT_ACT)
  ResMgr:load_set_icon(self.v_act_new_img, cfg_main_view.TitleIcon)
  self.v_uiobjects.ActivityNameImage:SetActive(false)
  self.v_uicompents.Activity4Btn_btn.interactable = false
end

function ui:refresh_red()
  local cfg = NoviceMgr:get_activity_flyback_info()
  local cfg_main_view = ShareRes.get_return_activity_main_view_cfg(RETURN_ACTIVITY_CFG_ID.SIGN_ACT)
  local award_num = cfg.sign_in_reward_bit or 0
  local count = 0
  for i = 1, cfg_main_view.AwardTotal do
    if self:get_bit(award_num, i) then
      count = count + 1
    end
  end
  self.v_sgin_num1.text = count
  self.v_sgin_num2.text = cfg_main_view.AwardTotal
  self.v_sgin_red_dot:SetActive(NoviceMgr:get_activity_flyback_sign_award_num(cfg_main_view.AwardTotal) > 0)
  self.v_new_red_dot:SetActive(NoviceMgr:get_red_state())
  self.v_task_red_dot:SetActive(NoviceMgr:get_task_red_state())
  cfg_main_view = ShareRes.get_return_activity_main_view_cfg(RETURN_ACTIVITY_CFG_ID.TASK_ACT)
  self.v_task_num1.text = NoviceMgr:get_task_award_num()
  self.v_task_num2.text = cfg_main_view.AwardTotal
  NoviceMgr:refresh_flyback_red()
end

function ui:refresh_show_time()
  if not self.v_end_time then
    return
  end
  local end_time = self.v_end_time
  local has_time = Util.is_more_than_zero(end_time)
  self.v_uiobjects.LessTime:SetActive(has_time)
  if not has_time then
    return
  end
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  local total_sec = end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_uiobjects.LessTime:SetActive(false)
    return
  end
  self.v_has_time = true
  self.v_uicompents.LessTime_txt.text = Date.get_time_formate_2(total_sec)
  self.v_reset_timer = CT_Timer:add_timer("ret_act_main_reset_timer", total_sec, function(sec)
    if sec > 0 and self.v_uicompents ~= nil then
      self.v_uicompents.LessTime_txt.text = Date.get_time_formate_2(sec)
    elseif self.v_reset_timer then
      CT_Timer:remove_timer(self.v_reset_timer)
      self.v_reset_timer = nil
    end
  end)
end

function ui:ui_on_hide()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  for _, ui_name in pairs(RETURN_ACTIVITY) do
    UIMgr:try_hide_ui(ui_name)
  end
  self:manual_close()
end

function ui:pop_up_precondition()
  return true
end

function ui:manual_close()
end

function ui:play_in_eff()
  self.v_uiobjects.Ani_UIActReturnMain_In:SetActive(false)
  self.v_uiobjects.Ani_UIActReturnMain_In:SetActive(true)
end

function ui:get_bit(num, idx)
  return 1 == (num >> idx - 1) % 2
end

return ui
