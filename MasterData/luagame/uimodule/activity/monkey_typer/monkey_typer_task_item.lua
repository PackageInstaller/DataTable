local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local Math = require("base.mathx")
local NAME_COLOR = {
  [true] = "292929",
  [false] = "4b463f"
}
local DESC_COLOR = {
  [true] = "484243",
  [false] = "575048"
}

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:play_finish_anim()
  self.v_uiobjects.Ani_Out:SetActiveEx(false)
  self.v_uiobjects.Ani_Out:SetActiveEx(true)
end

function ui:ui_on_hide()
  self:clear_wrap_items()
end

function ui:ui_on_destroy()
end

function ui:set_data(activity_id, task_id, jump_callback, show_jump_btn)
  self.v_activity_id = activity_id
  self.v_task_id = task_id
  self.jump_callback = jump_callback
  self.show_jump_btn = true == show_jump_btn
  self:refresh_task_info()
  self:refresh_task_get_state()
  self.v_uiobjects.Ani_In:SetActiveEx(false)
  self.v_uiobjects.Ani_Out:SetActiveEx(false)
  self.v_uiobjects.Ani_Refresh:SetActiveEx(false)
  self.v_uiobjects.Ani_In:SetActiveEx(true)
end

function ui:refresh_task_info()
  local task_data = TaskMgr:get_task_by_id(self.v_task_id) or WeeklyMgr:get_pvp_task_data(self.v_task_id)
  local task_cfg = ShareRes.get_task_cfg(self.v_task_id)
  local condition_id = task_cfg.Condition[1]
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local coms = self.v_uicompents
  coms.TaskName_txt.text = task_cfg.Name
  coms.TaskDesc_txt.text = task_cfg.Desc
  local progress_list = task_data.progress
  local progress = progress_list and #progress_list > 0 and progress_list[1].progress or 0
  local max = condition_cfg.Value
  local cur = Math.Clamp(progress or 0, 0, max)
  local now_progress_txt = coms.Progress_txt
  now_progress_txt.text = string.format("（%s/%s）", cur, max)
  self:set_button_listener(self.v_uicompents.BtnJump_btn, function()
    UIMgr:get_ui("monkey_typer_panel"):ui_show(self.v_activity_id)
  end)
  self:set_button_listener(self.v_uicompents.BtnRecive_btn, function()
    self.v_parent_ui:click_get_award_btn(self.v_task_id)
  end)
  self:refresh_award(task_cfg.Award)
end

function ui:refresh_task_get_state()
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  local task_data = TaskMgr:get_task_by_id(self.v_task_id) or WeeklyMgr:get_pvp_task_data(self.v_task_id)
  local task_cfg = ShareRes.get_task_cfg(self.v_task_id)
  local get_state = task_data.state
  local is_received = get_state == TASK_STATE.received
  objs.BtnRecive:SetActive(get_state == TASK_STATE.receive)
  objs.BtnJump:SetActive(get_state == TASK_STATE.none)
  objs.Bg:SetActive(not is_received)
  objs.CompleteBg:SetActive(is_received)
  objs.Complete:SetActive(is_received)
  local name_color = NAME_COLOR[not is_received]
  local desc_color = DESC_COLOR[not is_received]
  Util.set_color(coms.TaskName_txt, name_color)
  Util.set_color(coms.Progress_txt, name_color)
  Util.set_color(coms.TaskDesc_txt, desc_color)
  self:refresh_award_state(is_received)
end

function ui:refresh_award(award_group_id)
  local item_parent = self.v_uiobjects.AwardContent
  self:clear_wrap_items()
  self.v_award_item_list = {}
  local awards = {}
  ShareRes.get_item_obj_use_award_list(award_group_id, awards)
  for _, award_data in ipairs(awards) do
    local item_id = award_data.id or award_data[1] or award_data.ItemId
    local item_obj = self.v_parent_ui:get_award_item()
    item_obj.transform:SetParent(item_parent.transform)
    local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(award_data, true, false)
    table.insert(self.v_award_item_list, item)
  end
end

function ui:refresh_award_state(is_received)
  if not self.v_award_item_list then
    return
  end
  for _, award_item in ipairs(self.v_award_item_list) do
    Util.get_child_gameobj("Finish_", award_item:get_object()):SetActive(is_received)
  end
end

function ui:clear_wrap_items()
  if self.v_award_item_list then
    for idx = #self.v_award_item_list, 1, -1 do
      local item = self.v_award_item_list[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_award_item_list[idx] = nil
    end
    self.v_award_item_list = nil
  end
end

return ui
