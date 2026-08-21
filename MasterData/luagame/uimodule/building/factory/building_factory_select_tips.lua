local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BUILDING_LV_TITLE_TEMP = "BUILDING_LV_TITLE_TEMP"
local PRODUCTION_TEM = "PRODUCTION_TEM"
local Math = require("base.mathx")

function ui:on_click_production(material_id)
  if self.v_select_material_id == material_id then
    return
  end
  local building_level = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.FACTORY)
  local material_cfg = ShareRes.get_factory_material_cfg(material_id)
  if building_level < material_cfg.BuildingLevel then
    Util.show_message_tip(2321, material_cfg.BuildingLevel)
    return
  end
  local now_obj
  for id, obj in pairs(self.v_production_obj_map) do
    now_obj = self:get_child_gameobj("Now", obj)
    now_obj:SetActive(id == material_id)
  end
  local last_material = self.v_select_material_id
  self.v_select_material_id = material_id
  if Util.is_more_than_zero(last_material) then
    BuildingMgr:requst_factory_change_material(self.v_factory_id, self.v_select_material_id, function()
      if self:visible() then
        self:ui_hide()
      end
    end)
  else
    BuildingMgr:requst_factory_working(self.v_factory_id, self.v_select_material_id, function()
      if self:visible() then
        self:ui_hide()
      end
    end)
  end
end

function ui:on_click_close_btn()
  self:ui_hide()
end

function ui:ui_finish_load()
  self.v_select_material_id = nil
  self.v_production_obj_map = {}
  self:set_button("BgClose", function()
    self:on_click_close_btn()
  end)
  self:set_button("BtnClose", function()
    self:on_click_close_btn()
  end)
  self:register_exist_auto_template(PRODUCTION_TEM, self.v_uiobjects.ProductionTem, self.v_uiobjects.ProductionContent)
  self:register_exist_auto_template(BUILDING_LV_TITLE_TEMP, self.v_uiobjects.BuildingLvTitle, self.v_uiobjects.ProductionContent)
end

function ui:ui_on_show(factory_id)
  local factory_data = BuildingMgr:get_factory_data(factory_id)
  self.v_select_material_id = factory_data.material_id
  self.v_factory_id = factory_id
  self:refresh_material()
end

function ui:ui_on_hide()
  self:give_back_auto_cache(BUILDING_LV_TITLE_TEMP)
  self:give_back_auto_cache(PRODUCTION_TEM)
  self.v_select_material_id = nil
  self.v_factory_id = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_material()
  self:give_back_auto_cache(BUILDING_LV_TITLE_TEMP)
  self:give_back_auto_cache(PRODUCTION_TEM)
  local building_level = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.FACTORY)
  local all_id_list = ShareRes.get_factory_material_level_id_list()
  local all_material_cfg = ShareRes.get_factory_material_cfg()
  local title_obj, building_lv_txt, material_cfg, production_obj, production_icon, speed_text, production_name, lock_obj, now_obj, btn, icon_path, item_name, is_unlock
  for _, id_list in ipairs(all_id_list) do
    title_obj = self:get_auto_cache(BUILDING_LV_TITLE_TEMP)
    building_lv_txt = self:get_text("BuildingLv", title_obj)
    for key, material_id in ipairs(id_list) do
      material_cfg = all_material_cfg[material_id]
      is_unlock = building_level >= material_cfg.BuildingLevel
      icon_path = ShareRes.get_item_icon_path(material_id)
      item_name = ShareRes.get_item_name(material_id)
      self.v_production_obj_map[material_id] = self:get_auto_cache(PRODUCTION_TEM)
      production_obj = self.v_production_obj_map[material_id]
      production_icon = self:get_image("ProductionIcon", production_obj)
      ResMgr:load_set_icon(production_icon, icon_path)
      local level_info
      local level = math.min(building_level, material_cfg.MaxLevelInfo.Level)
      for i = level, material_cfg.MaxLevelInfo.Level do
        level_info = material_cfg.LevelInfo[i]
        if level_info then
          break
        end
      end
      speed_text = self:get_text("Speed", production_obj)
      speed_text.text = Util.format_str("{1}/{2}分钟", level_info.Speed, level_info.TimeUnit)
      production_name = self:get_text("ProductionName", production_obj)
      production_name.text = item_name
      lock_obj = self:get_child_gameobj("Lock", production_obj)
      lock_obj:SetActive(not is_unlock)
      now_obj = self:get_child_gameobj("Now", production_obj)
      now_obj:SetActive(is_unlock and self.v_select_material_id == material_id)
      btn = self:get_button(nil, production_obj)
      self:set_button_listener(btn, function()
        self:on_click_production(material_id)
      end)
    end
    building_lv_txt.text = material_cfg.BuildingLevel
  end
end

return ui
