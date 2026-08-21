local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TYPE_TO_REDPOINT_NAME_MAP = {
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT] = "EventRed",
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT] = "OrnRed",
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT] = "AbilityRed",
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EQUATION] = "EquationRed"
}

function ui:on_click_ability_btn()
  UIMgr:get_ui("fate_book_illustrated_ability"):ui_show()
end

function ui:on_click_event_btn()
  UIMgr:get_ui("fate_book_illustrated_event"):ui_show()
end

function ui:on_click_ornament_btn()
  UIMgr:get_ui("fate_book_illustrated_orn"):ui_show()
end

function ui:on_click_equation_btn()
  UIMgr:get_ui("fate_book_illustrated_equation"):ui_show()
end

function ui:on_click_return_btn()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnAbility", function()
    self:on_click_ability_btn()
  end)
  self:set_button("BtnEvent", function()
    self:on_click_event_btn()
  end)
  self:set_button("BtnOrnament", function()
    self:on_click_ornament_btn()
  end)
  self:set_button("BtnEquation", function()
    self:on_click_equation_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
end

function ui:ui_on_show()
  self:refersh_view()
  self:refresh_redpoint()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refersh_view()
  local cur_ount, all_count
  cur_ount, all_count = self:get_event_count()
  self.v_uicompents.EventNow_txt.text = cur_ount
  self.v_uicompents.EventMax_txt.text = all_count
  cur_ount, all_count = self:get_orn_count()
  self.v_uicompents.OrnNow_txt.text = cur_ount
  self.v_uicompents.OrnMax_txt.text = all_count
  cur_ount, all_count = self:get_ability_count()
  self.v_uicompents.AbilityNow_txt.text = cur_ount
  self.v_uicompents.AbilityMax_txt.text = all_count
  cur_ount, all_count = self:get_equation_count()
  self.v_uicompents.EquationNow_txt.text = cur_ount
  self.v_uicompents.EquationMax_txt.text = all_count
end

function ui:refresh_redpoint()
  for map_type, red_obj_name in pairs(TYPE_TO_REDPOINT_NAME_MAP) do
    self.v_uiobjects[red_obj_name]:SetActive(self:get_redpoint_state(map_type))
  end
end

function ui:get_redpoint_state(map_type)
  local task_group_id, have_red
  task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(map_type)
  have_red = TaskMgr:get_task_group_red(task_group_id)
  return have_red
end

function ui:get_event_count()
  local all_cfg
  local cur_count = 0
  local all_count = 0
  local data = FateBookMgr:get_illustrated_data(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT)
  all_cfg = self:get_all_cfg(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT)
  for id, cfg in pairs(all_cfg) do
    if cfg.Id > 0 and cfg.EventId and Util.is_more_than_zero(cfg.Ifshow) then
      for key, event_id in pairs(cfg.EventId) do
        if event_id > 0 then
          all_count = all_count + 1
          if data[event_id] then
            cur_count = cur_count + 1
          end
        end
      end
    end
  end
  return cur_count, all_count
end

function ui:get_ability_count()
  local all_cfg, data, cur_ount
  local all_count = 0
  all_cfg = self:get_all_cfg(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT)
  for id, cfg in pairs(all_cfg) do
    if Util.is_more_than_zero(cfg.Sect) then
      all_count = all_count + 1
    end
  end
  data = FateBookMgr:get_illustrated_data(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT)
  cur_ount = UtilTable.hash_lenth(data)
  return cur_ount, all_count
end

function ui:get_orn_count()
  local gourp_data = self:get_all_cfg(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT, -1)
  local all_count = #gourp_data
  local cur_ount = 0
  local orn_unlock_data = FateBookMgr:get_illustrated_data(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT)
  if not gourp_data then
    return
  end
  local cfg, orn_id
  for index = 1, all_count do
    orn_id = gourp_data[index]
    cfg = ShareRes.get_ornaments(orn_id)
    if orn_unlock_data[cfg.Id] then
      cur_ount = cur_ount + 1
    end
  end
  return cur_ount, all_count
end

function ui:get_equation_count()
  local all_cfg, data, cur_ount
  local all_count = 0
  all_cfg = self:get_all_cfg(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EQUATION)
  local temp_map = {}
  for _, cfg in pairs(all_cfg) do
    for key, equation_id in pairs(cfg.EquationId) do
      if not temp_map[equation_id] then
        temp_map[equation_id] = true
        all_count = all_count + 1
      end
    end
  end
  data = FateBookMgr:get_illustrated_data(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EQUATION)
  cur_ount = UtilTable.hash_lenth(data)
  return cur_ount, all_count
end

function ui:get_all_cfg(map_type, ...)
  if map_type == Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT then
    return ShareRes.get_curse_event_group_cfg(...)
  elseif map_type == Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT then
    return ShareRes.create("activity.ability", ...)
  elseif map_type == Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT then
    return ShareRes.get_ornaments_group_data(...)
  elseif map_type == Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EQUATION then
    return ShareRes.get_curse_equation_illustrated_cfg(...)
  end
end

function ui:cache_ui()
  return true
end

return ui
