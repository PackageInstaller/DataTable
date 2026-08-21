local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local MONKEY_TYPER_AWARD_ITEM_TEMP_KEY = "MONKEY_TYPER_AWARD_ITEM_TEMP_KEY"

function ui:ui_finish_load()
  self:set_button("BtnJump", function()
    UIMgr:get_ui("monkey_typer_panel"):ui_show(self.v_activity_id)
  end)
  self:set_button("BtnAward", function()
    UIMgr:get_ui("monkey_typer_task_panel"):ui_show(self.v_activity_id)
  end)
  self:register_exist_auto_template(MONKEY_TYPER_AWARD_ITEM_TEMP_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  self.v_activity_cfg = ShareRes.get_activity_cfg(activity_id)
  local task_cfg = ShareRes.create("activity.monkey_typewriter_misc")[activity_id]
  if not task_cfg then
    Log.Error("猴子打字机任务表无对应id配置：", activity_id)
    return
  end
  self.v_award_group = task_cfg.AwardGroupId
  self.v_uicompents.Desc_txt.text = task_cfg.Desc
  self:update_info()
  MonkeyTyperMgr:req_refresh_question(self.v_activity_id)
  NoviceMgr:read_novice_activity(self.v_activity_id)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedPoint, RedEnum.MONKEY_TYPER_OVERHEAT)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.AwardRedPoint, RedEnum.MONKEY_TYPER_ACT_AWARD)
end

function ui:ui_on_hide()
  self:clear_wrap_award()
end

function ui:ui_on_destroy()
end

function ui:update_info()
  self:refresh_award()
  self:refresh_time_remaining()
end

function ui:refresh_state()
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local is_unlock = nil ~= activity_data
  if not is_unlock then
    local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
    self.v_uicompents.UnLockDesc_txt.text = ShareRes.get_condition_desc(activity_cfg.Condition)
  end
end

function ui:refresh_award()
  if not self.v_award_group then
    return
  end
  self:give_back_auto_cache(MONKEY_TYPER_AWARD_ITEM_TEMP_KEY)
  self:clear_wrap_award()
  self.v_item_list = {}
  local awards = {}
  ShareRes.get_item_obj_use_award_list(self.v_award_group, awards)
  for _, award_data in ipairs(awards) do
    local item_obj = self:get_auto_cache(MONKEY_TYPER_AWARD_ITEM_TEMP_KEY)
    local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(award_data, true, true)
    table.insert(self.v_item_list, item)
  end
end

function ui:clear_wrap_award()
  if self.v_item_list then
    for key, item in pairs(self.v_item_list) do
      item:ui_hide()
      item:ui_destroy()
      self.v_item_list[key] = nil
    end
    self.v_item_list = nil
  end
end

function ui:ui_on_update()
  self:refresh_time_remaining()
end

function ui:refresh_time_remaining()
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local time_length = NoviceMgr:get_time_remaining(self.v_activity_cfg.TimeType, self.v_activity_cfg.StopTime, activity_data.open_time, self.v_activity_cfg.SustainTime)
  self.v_uiobjects.LessTime:SetActiveEx(nil ~= time_length)
  if time_length then
    self.v_uicompents.LessTime_txt.text = Date.get_time_format_7(time_length)
  end
end

return ui
