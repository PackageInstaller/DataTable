local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ADVENTRUE_CLUE_GROUP_TEMP = "ADVENTRUE_CLUE_GROUP_TEMP"
local ADVENTRUE_SELECT_CLUE_TEMP = "ADVENTRUE_SELECT_CLUE_TEMP"
local ADVENTRUE_CLUE_AWARD_TEMP = "ADVENTRUE_CLUE_AWARD_TEMP"
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local TIPS_CULE_ITEM = require("uimodule.building.adventrue.building_adventrue_tips_clue_item")

function ui:on_operat_clue(is_add, clue_id)
  local cfg = ShareRes.get_building_adventure_type(self.v_task_data.type)
  local max_clue_count = BuildingMgr:get_clue_data_count(clue_id)
  self.v_select_clue_count_map[clue_id] = self.v_select_clue_count_map[clue_id] or 0
  local cur_clue_count = self.v_select_clue_count_map[clue_id]
  if is_add then
    if max_clue_count <= cur_clue_count then
      return
    end
    local total_count = 0
    for _, count in pairs(self.v_select_clue_count_map) do
      total_count = total_count + count
    end
    if total_count >= cfg.ClueCount then
      return
    end
    self.v_select_clue_count_map[clue_id] = cur_clue_count + 1
  else
    if cur_clue_count <= 0 then
      return
    end
    self.v_select_clue_count_map[clue_id] = cur_clue_count - 1
  end
  self:after_operat_clue()
end

function ui:after_operat_clue()
  self:refresh_select_clue_info()
  self:refresh_clue_award_info()
  for clue_id, item in pairs(self.v_tips_clue_item_map) do
    item:on_select(self.v_select_clue_count_map[clue_id])
  end
end

function ui:on_click_confirm_btn()
  BuildingMgr:set_select_clue_map(self.v_select_clue_count_map)
  local building_adventrue_room = UIMgr:try_get_visible_ui("building_adventrue_room")
  if building_adventrue_room then
    building_adventrue_room:after_select_clue()
  end
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnConfirm", function()
    self:on_click_confirm_btn()
  end)
  self.v_tips_clue_item_map = {}
  self.v_award_item_list = {}
  self:register_exist_auto_template(ADVENTRUE_CLUE_GROUP_TEMP, self.v_uiobjects.CuleGroupTem, self.v_uiobjects.CuleGroupContent)
  self:register_exist_auto_template(ADVENTRUE_SELECT_CLUE_TEMP, self.v_uiobjects.SelectClue, self.v_uiobjects.SelectClueContent)
  self:register_exist_auto_template(ADVENTRUE_CLUE_AWARD_TEMP, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardContent)
end

function ui:ui_on_show(task_data, task_type)
  BuildingMgr:check_all_clue_is_expier(true)
  self.v_task_data = task_data
  self.v_select_clue_count_map = BuildingMgr:get_select_clue_map() or {}
  self:refresh_clue_info()
  self:refresh_select_clue_info()
  self:refresh_clue_award_info()
end

function ui:ui_on_hide()
  BuildingMgr:remove_check_all_clue_expier_timer()
  self:clear_tips_clue_item()
  self:clear_award_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_clue_info()
  self:clear_tips_clue_item()
  local clue_data = BuildingMgr:get_clue_data_id_map()
  local temp_list = {}
  for key, map in pairs(clue_data) do
    local _, data = next(map)
    if data then
      temp_list[#temp_list + 1] = data
    end
  end
  table.sort(temp_list, function(a, b)
    if a.id ~= b.id then
      return a.id < b.id
    else
      return false
    end
  end)
  local obj, clue_id
  for _, data in ipairs(temp_list) do
    clue_id = data.id
    obj = self:get_auto_cache(ADVENTRUE_CLUE_GROUP_TEMP)
    self.v_tips_clue_item_map[clue_id] = TIPS_CULE_ITEM:ui_wrap_ex(self, obj, true)
    self.v_tips_clue_item_map[clue_id]:set_data_on_add_clue(data, self.v_select_clue_count_map[clue_id])
  end
end

function ui:refresh_select_clue_info()
  local temp_list = {}
  for clue_id, count in pairs(self.v_select_clue_count_map) do
    for index = 1, count do
      temp_list[#temp_list + 1] = clue_id
    end
  end
  table.sort(temp_list, function(a, b)
    if a ~= b then
      return a < b
    else
      return false
    end
  end)
  local type_cfg = ShareRes.get_building_adventure_type(self.v_task_data.type)
  local max_clue_count = type_cfg.ClueCount
  local cfg
  self:give_back_auto_cache(ADVENTRUE_SELECT_CLUE_TEMP)
  local obj, clue_bg, clue_icon, path
  for index = 1, max_clue_count do
    obj = self:get_auto_cache(ADVENTRUE_SELECT_CLUE_TEMP)
    clue_bg = self:get_child_gameobj("ClueBg_", obj)
    if nil ~= temp_list[index] then
      clue_bg:SetActive(true)
      clue_icon = self:get_image("ClueIcon_", clue_bg)
      path = UtilUI.get_item_icon(temp_list[index])
      ResMgr:load_set_icon(clue_icon, path)
    else
      clue_bg:SetActive(false)
    end
  end
end

function ui:refresh_clue_award_info()
  self:clear_award_item()
  if not self.v_select_clue_count_map then
    return
  end
  local data_list = {}
  local cfg
  
  local function build_data_func(award_cfg, index)
    return {
      id = award_cfg.ItemId,
      count = award_cfg.Num * self.v_temp_clue_count
    }
  end
  
  for clue_id, count in pairs(self.v_select_clue_count_map) do
    if count > 0 then
      cfg = ShareRes.get_building_clue_cfg(clue_id)
      self.v_temp_clue_count = count
      ShareRes.get_item_obj_use_award_list(cfg.AwardId, data_list, build_data_func)
    end
  end
  for index, data in ipairs(data_list) do
    function data.cb()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data.id,
        
        jump_cb = function()
          self:ui_hide()
        end
      })
    end
    
    local obj = self:get_auto_cache(ADVENTRUE_CLUE_AWARD_TEMP)
    local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
    item:set_data(data)
    self.v_award_item_list[index] = item
  end
end

function ui:clear_tips_clue_item()
  self:give_back_auto_cache(ADVENTRUE_CLUE_GROUP_TEMP)
  for key, item in pairs(self.v_tips_clue_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_tips_clue_item_map[key] = nil
  end
end

function ui:clear_award_item()
  self:give_back_auto_cache(ADVENTRUE_CLUE_AWARD_TEMP)
  for key, item in pairs(self.v_award_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_item_list[key] = nil
  end
end

return ui
