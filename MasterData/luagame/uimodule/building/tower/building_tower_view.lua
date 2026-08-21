local Base = require("ui.uibase")
local BUILDING_LEVEL_ITEM = require("uimodule.building.tower.building_level_item")
local ui = Util.create_child_mt(Base)
local BUILDINGT_TOWER_LV_TEMP = "BUILDINGT_TOWER_LV_TEMP"
local BUILDINGT_TOWER_EMPTY_TEMP = "BUILDINGT_TOWER_EMPTY_TEMP"
local BUILDING_TYPE = Config.CommonDefine.BUILDING_TYPE
local BUILDING_ROOT_NAME_MAP = {
  [BUILDING_TYPE.TOWER] = "MainTower",
  [BUILDING_TYPE.ADVENTURE] = "Task",
  [BUILDING_TYPE.FACTORY] = "ProductRoom",
  [BUILDING_TYPE.STAMINA] = "Force",
  [BUILDING_TYPE.COMBINE] = "ItemSynthesis"
}

function ui:on_building_data_update()
  self:refresh_view()
end

function ui:on_click_return_btn()
  self:ui_hide()
end

function ui:ui_finish_load()
  self.v_asset_item_info_list = {
    {item_id = 31}
  }
  self.v_level_item_map = {}
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:register_exist_auto_template(BUILDINGT_TOWER_LV_TEMP, self.v_uiobjects.LvTem, self.v_uiobjects.LvTemContent)
  self:register_exist_auto_template(BUILDINGT_TOWER_EMPTY_TEMP, self.v_uiobjects.EmptyTem, self.v_uiobjects.LvTemContent)
end

function ui:ui_on_show(building_type, level)
  self:bind_auto_mq(Const.MSG_ON_BUILDING_DATA_UPDATE, self.on_building_data_update, self)
  self:get_panel("level_up_view"):set_enable(false)
  self:get_panel("level_up_suc_view"):set_enable(false)
  self:build_data()
  self:refresh_view(building_type, level)
end

function ui:ui_on_hide()
  self:clear_level_item()
end

function ui:ui_on_destroy()
end

function ui:build_data()
  local all_lv_cfg = ShareRes.get_building_level_cfg()
  self.v_builduing_level_slot_map = {}
  for building_type, lv_cfgs in pairs(all_lv_cfg) do
    local max_lv = #lv_cfgs
    local lv_cfg, lv_map
    for lv = 1, max_lv do
      lv_cfg = lv_cfgs[lv]
      local insert_lv
      if lv_cfg.BuildingUnlockMap and Util.is_more_than_zero(lv_cfg.BuildingUnlockMap.Level) then
        insert_lv = lv_cfg.BuildingUnlockMap.Level
      else
        insert_lv = lv
      end
      self.v_builduing_level_slot_map[insert_lv] = self.v_builduing_level_slot_map[insert_lv] or {}
      lv_map = self.v_builduing_level_slot_map[insert_lv]
      lv_map[building_type] = lv_cfg
    end
  end
end

function ui:refresh_view(target_building_type, target_level)
  self:clear_level_item()
  local root_name, name_txt, building_cfg
  local length = #self.v_builduing_level_slot_map
  for lv = 1, length do
    local type_to_lv_map = self.v_builduing_level_slot_map[lv]
    for _, building_type in pairs(BUILDING_TYPE) do
      root_name = BUILDING_ROOT_NAME_MAP[building_type]
      if root_name and self.v_uiobjects[root_name] then
        building_cfg = ShareRes.get_building_cfg(building_type)
        name_txt = self.v_uicompents[root_name .. "Name_txt"]
        name_txt.text = building_cfg.Name
        local lv_cfg = type_to_lv_map[building_type]
        local level = BuildingMgr:get_building_level(building_type)
        local obj
        if lv_cfg then
          obj = self:get_auto_cache(BUILDINGT_TOWER_LV_TEMP)
          local item = BUILDING_LEVEL_ITEM:ui_wrap_ex(self, obj, true)
          item:set_data(building_type, lv_cfg, level)
          self.v_level_item_map[building_type] = self.v_level_item_map[building_type] or {}
          self.v_level_item_map[building_type][lv] = item
        else
          obj = self:get_auto_cache(BUILDINGT_TOWER_EMPTY_TEMP)
          local line_obj = self:get_child_gameobj("Line_", obj)
          local light = self:get_child_gameobj("Line_/LineActive_", obj)
          local light_on = false
          local next_slop, next_lv_cfg
          if 1 ~= lv and length >= lv + 1 then
            for i = lv + 1, length do
              next_slop = self.v_builduing_level_slot_map[lv + 1]
              if next_slop and next_slop[building_type] then
                next_lv_cfg = next_slop[building_type]
                break
              end
            end
            if next_lv_cfg and self:get_line_active(next_lv_cfg, level) then
              light_on = true
            end
            light:SetActive(light_on)
            line_obj:SetActive(true)
          else
            line_obj:SetActive(false)
          end
        end
        obj.transform:SetParent(self.v_uiobjects[root_name].transform)
      else
        Log.Error("建筑类型获取预制节点失败，类型：", building_type)
      end
    end
  end
  if target_building_type and target_level then
    local level_up_view = self:get_panel("level_up_view")
    level_up_view:set_enable(true, target_building_type, target_level)
  end
end

function ui:get_line_active(lv_cfg, cur_level)
  local level = lv_cfg.Level
  local is_unlock = level <= cur_level + 1
  local is_next_level = cur_level + 1 == level
  local condition_pass = BuildingMgr:check_condition_list(lv_cfg.Condition)
  local enough = Util.check_item_cost_enough(lv_cfg.ConsumeItemId, lv_cfg.ConsumeItemCount)
  return is_unlock or not is_unlock and condition_pass and enough and is_next_level
end

function ui:clear_level_item()
  self:give_back_auto_cache(BUILDINGT_TOWER_EMPTY_TEMP)
  for key, map in pairs(self.v_level_item_map) do
    for k, item in pairs(map) do
      item:ui_hide()
      item:ui_destroy()
      map[k] = nil
    end
    self.v_level_item_map[key] = nil
  end
end

return ui
