local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local curse_common_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local TAKS_AWARD_TYPE = curse_common_def.TAKS_AWARD_TYPE
local PRORITY_ICON_PREFIX = curse_common_def.PRORITY_ICON_PREFIX
local QUALITY_TO_IDX = curse_common_def.QUALITY_TO_IDX
local BIND_TYPE = Config.BIND_TYPE
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local TIPS_OFFSET = {x = 85, y = -95}
local TASK_TEM_BG1 = {
  [1] = "FateBook/Event_db_rw1",
  [2] = "FateBook/Event_db_rw2",
  [3] = "FateBook/Event_db_rw3"
}
local TASK_TEM_BG2 = {
  [1] = "UIEvent03/Event_bg_rwk03",
  [2] = "UIEvent03/Event_bg_rwk02",
  [3] = "UIEvent03/Event_bg_rwk01"
}
local TASK_TEM_ICON = {
  [1] = "UIEvent03/Event_icon_rwtb03",
  [2] = "UIEvent03/Event_icon_rwtb02",
  [3] = "UIEvent03/Event_icon_rwtb01"
}
local CURSE_DESC = "降低迷失值可延缓诅咒带来的负面影响"
local MODEL = {
  v_task_name = {
    "TaskName",
    BIND_TYPE.TEXT
  },
  v_task_desc = {
    "TaskDesc",
    BIND_TYPE.TEXT
  },
  v_award_desc = {
    "AwardDesc",
    BIND_TYPE.TEXT
  },
  v_orn_icon = {
    "OrnIcon",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  local tog = self:get_toggle(nil, self.v_object)
  self:set_toggle_listener(tog, function(is_on)
    if is_on then
      self:_on_select_toggle(self.v_task_id)
    end
  end)
  self:set_toggle_listener(tog, function(is_on)
    if is_on then
      self:_on_select_toggle(self.v_task_id)
    end
  end)
  self.v_uiobjects.TaskCondition:SetActive(false)
  self.v_condition_obj_list = {}
end

function ui:set_data(task_cfg, show_only)
  self.v_show_only = show_only
  self.v_task_id = task_cfg.id
  local task_reward = task_cfg.task_reward
  local cfg = ShareRes.get_curse_task(self.v_task_id)
  self.v_task_name.text = cfg.missionTitle
  self.v_task_desc.text = cfg.missionIntroduce
  local str
  str = cfg.AwardText
  self.v_award_desc.text = Util.format_str(str)
  local is_random_orn = task_reward.reward_type == TAKS_AWARD_TYPE.DROP_RAMDOM_ORNAMENT
  local is_ornament = task_reward.reward_type == TAKS_AWARD_TYPE.DROP_ORNAMENT
  local is_ability = task_reward.reward_type == TAKS_AWARD_TYPE.ABILITY_DROP
  local is_currency = task_reward.reward_type == TAKS_AWARD_TYPE.CURRENCY_DROP
  local is_curse = task_reward.reward_type == TAKS_AWARD_TYPE.DECREASE_CURSE
  self.v_uiobjects.OrnIcon:SetActive(is_ornament)
  self.v_uiobjects.TalentIcon:SetActive(is_ability)
  self.v_uiobjects.ItemIcon:SetActive(is_currency)
  if is_currency then
    local item_id = cfg.AwardParam
    local icon_path = ShareRes.get_item_icon_path(item_id)
    ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, icon_path)
  end
  self.v_uiobjects.BtnDetail:SetActive(is_ornament)
  self.v_uiobjects.RandomOrnIcon:SetActive(is_random_orn)
  self.v_uiobjects.CurseIcon:SetActive(is_curse)
  if TASK_TEM_BG1[cfg.Level] then
    local img = self:get_image()
    ResMgr:load_set_icon(img, TASK_TEM_BG1[cfg.Level], nil, true, self)
  else
    Log.Error("获取难度对应图片失败", cfg.Level)
  end
  if is_ornament then
    self:set_button("BtnDetail", function()
      local ornaments_data = {
        id = 1,
        item_id = task_reward.id
      }
      local data = {
        ornaments_data = ornaments_data,
        award_type = curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ORNAMENT
      }
      ChallengeRingPlusMgr:check_need_push_update_queue(data)
    end)
  end
  local tog = self:get_toggle(nil, self.v_object)
  if tog.isOn then
    self:_on_select_toggle()
  end
  if self.v_show_only then
    local obj, now_txt, max_txt, condition_cfg
    local index = 1
    if cfg.Condition and Util.is_more_than_zero(cfg.Condition[index]) then
      condition_cfg = ShareRes.get_battle_task_condition_cfg(cfg.Condition[index])
      obj = self:get_condition_obj(index)
      obj:ResetAttr()
      obj:SetActive(true)
      now_txt = self:get_text("Text/ConditionNow", obj).component
      now_txt.text = task_cfg.progress[index] and task_cfg.progress[index].progress or 0
      max_txt = self:get_text("Text/ConditionNow/And/ConditionMax", obj).component
      max_txt.text = condition_cfg.Value
    end
  else
    self.v_uiobjects.TaskCondition:SetActive(false)
  end
end

function ui:_on_select_toggle()
  self.v_parent_ui:set_select_task(self.v_task_id)
end

function ui:show_tips(open, desc, x, y)
  self.v_parent_ui:show_tips(open, desc, x, y)
end

function ui:get_condition_obj(index)
  if Util.is_nil(self.v_condition_obj_list[index]) then
    local obj = ResMgr:instantiate(self.v_uiobjects.TaskCondition)
    self.v_condition_obj_list[index] = obj
    self.v_condition_obj_list[index].transform:SetParent(self.v_uiobjects.ConditionLayout.transform)
    self.v_condition_obj_list[index].transform:ResetAttr()
  end
  return self.v_condition_obj_list[index]
end

function ui:ui_on_hide()
  for key, obj in pairs(self.v_condition_obj_list) do
    ResMgr:destroy_gameobj(obj)
    self.v_condition_obj_list[key] = nil
  end
end

return ui
