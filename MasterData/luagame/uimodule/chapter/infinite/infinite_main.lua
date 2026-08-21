local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local INFINITE_ITEM_KEY = "INFINITE_ITEM_KEY"
local MODEL = {
  v_inf_content = {
    "EndlessStageContent",
    BIND_TYPE.OBJECT
  },
  v_inf_template = {
    "EndlessStageTem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(INFINITE_ITEM_KEY, self.v_inf_template, self.v_inf_content)
end

function ui:ui_on_show()
  self:init_infinite_list()
end

function ui:ui_on_hide()
  self.v_infinite_item_list = nil
end

function ui:cache_ui()
  return true
end

function ui:init_infinite_list()
  self.v_infinite_item_list = {}
  local infinite_cfg_list = ShareRes.get_inf_chapter_cfg()
  self:give_back_auto_cache(INFINITE_ITEM_KEY)
  local new_infinite_cfg_list = {}
  for _, infinite_cfg in pairs(infinite_cfg_list) do
    _tinsert(new_infinite_cfg_list, infinite_cfg)
  end
  table.sort(new_infinite_cfg_list, function(a, b)
    local a_cfg = ShareRes.get_inf_chapter_cfg(a.Id)
    local b_cfg = ShareRes.get_inf_chapter_cfg(b.Id)
    local a_is_unlock = ChapterMgr:get_inf_chapter_data(a.Id) and 1 or 0
    local b_is_unlock = ChapterMgr:get_inf_chapter_data(b.Id) and 1 or 0
    if a_is_unlock == b_is_unlock then
      if a_cfg.Priority == b_cfg.Priority then
        return a_cfg.Id < b_cfg.Id
      else
        return a_cfg.Priority > b_cfg.Priority
      end
    else
      return a_is_unlock > b_is_unlock
    end
  end)
  for index, infinite_cfg in ipairs(new_infinite_cfg_list) do
    local infinite_id = infinite_cfg.Id
    if not infinite_cfg.IsHide then
      self:new_infinite_item(infinite_id)
    end
  end
end

function ui:new_infinite_item(infinite_id)
  local infinite_item = self:get_auto_cache(INFINITE_ITEM_KEY)
  self.v_infinite_item_list[infinite_id] = infinite_item
  self:refresh_infinite_item_info(infinite_id)
  self:set_button_listener(Util.get_button(nil, infinite_item), function()
    self:click_infinite_item(infinite_id)
  end)
end

function ui:refresh_infinite_item_info(infinite_id)
  local infinite_item = self.v_infinite_item_list[infinite_id]
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
  local bg_img = Util.get_image("Content/StageImageBg/StageImage", infinite_item)
  ResMgr:load_set_icon(bg_img, infinite_cfg.BgName, nil, true, self)
  local name_text = Util.get_text("Content/StageName", infinite_item)
  name_text.text = infinite_cfg.Name
  local english_name = Util.get_text("Content/EnStageName", infinite_item)
  english_name.text = infinite_cfg.EnglishName
  local content_canvas = self:get_canvas_group(nil, Util.get_child("Content", infinite_item))
  local lock_obj = Util.get_child_gameobj("Lock", infinite_item)
  local task_layout = Util.get_child_gameobj("Content/TaskLayout", infinite_item)
  local stage_tem_red_point = Util.get_child_gameobj("Content/StageTemRedPoint", infinite_item)
  if ChapterMgr:get_inf_chapter_data(infinite_id) then
    content_canvas.alpha = 1
    lock_obj:SetActive(false)
    task_layout:SetActive(true)
    stage_tem_red_point:SetActive(ChapterMgr:get_inf_single_red_point_state(infinite_id))
    local task_progress = Util.get_text("Content/TaskLayout/TaskProgress", infinite_item)
    local task_list = ShareRes.get_task_group(infinite_cfg.TaskGroup)
    local all_task_count = UtilTable.hash_lenth(task_list)
    local already_get_reward_count = 0
    for _, task in pairs(task_list) do
      local task_status = TaskMgr:get_task_state(task.Id)
      if task_status == TASK_STATE.received then
        already_get_reward_count = already_get_reward_count + 1
      end
    end
    task_progress.text = string.format("<color=\"#FDA300\">%d</color><color=\"#FFFFFF\">/%d</color>", already_get_reward_count, all_task_count)
  else
    content_canvas.alpha = 0.6
    lock_obj:SetActive(true)
    task_layout:SetActive(false)
    stage_tem_red_point:SetActive(false)
    local con_cfg = ShareRes.create("condition.condition", infinite_cfg.Condition)
    local unlock_condition_text = Util.get_text("Lock/UnlockCondition", infinite_item)
    unlock_condition_text.text = con_cfg.Desc
  end
end

function ui:click_infinite_item(infinite_id)
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(infinite_id)
  if not ChapterMgr:get_inf_chapter_data(infinite_id) then
    local con_cfg = ShareRes.create("condition.condition", infinite_cfg.Condition)
    Util.show_message_tip(con_cfg.Desc)
    return
  end
  ChapterMgr:remove_infinite_new_mask(infinite_id)
  UIMgr:get_ui("infinite_point"):ui_show(infinite_id)
end

return ui
