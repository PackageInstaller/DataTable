local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BUILDING_CONFIG = require("uimodule.building.building_config")
local DISPATCH_TASK_END_BOX_TEMP = "DISPATCH_TASK_END_BOX_TEMP"
local BUILDING_ONE_KEY_GET_AWARD_ITEM = require("uimodule.building.adventrue.building_one_key_get_award_item")

function ui:on_click_BgClose()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:on_click_BgClose()
  end)
  self:register_exist_auto_template(DISPATCH_TASK_END_BOX_TEMP, self.v_uiobjects.DispatchTaskEndBox, self.v_uiobjects.DispatchTaskEndBoxConten)
  self.v_item_list = {}
end

function ui:ui_on_show(task_data_list)
  table.sort(task_data_list, function(a, b)
    local a_task_cfg, b_task_cfg = ShareRes.get_adventrue_task_cfg(a.id), ShareRes.get_adventrue_task_cfg(b.id)
    if a_task_cfg and b_task_cfg and a_task_cfg.Quality ~= b_task_cfg.Quality then
      return a_task_cfg.Quality > b_task_cfg.Quality
    end
    return false
  end)
  for _, task_data in ipairs(task_data_list) do
    if task_data.type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BRANCH then
      self.v_branch_task_id = task_data.id
    end
    local obj = self:get_auto_cache(DISPATCH_TASK_END_BOX_TEMP)
    local item = BUILDING_ONE_KEY_GET_AWARD_ITEM:ui_wrap_ex(self, obj, true)
    item:set_data(task_data)
    self.v_item_list[#self.v_item_list + 1] = item
  end
end

function ui:ui_on_hide()
  for index, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[index] = nil
  end
  if self.v_branch_task_id then
    local task_id = self.v_branch_task_id
    local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
    local story_id, chain_centre_event_id
    if task_cfg then
      story_id = task_cfg.StoryId
      chain_centre_event_id = task_cfg.ChainCentreEventId
    end
    
    local function story_end_cb()
      BuildingMgr:try_show_adventrue_task_award()
      if Util.is_more_than_zero(chain_centre_event_id) then
        UIMgr:get_ui("building_batch_tips"):ui_show(task_id, true)
      end
    end
    
    if Util.is_more_than_zero(story_id) then
      StoryMgr:on_start(story_id)
      StoryMgr:set_story_end_cb(story_id, story_end_cb)
    else
      story_end_cb()
    end
  end
  self.v_branch_task_id = nil
end

function ui:ui_on_destroy()
end

return ui
