local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local PREVIEW_FUNC_TEMP_KEY = "PREVIEW_FUNC_TEMP_KEY"
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local PREVIEW_PANEL_NAME = curse_common_define.PREVIEW_PANEL_NAME
local TOG_PANEL_NAME = {
  [1] = PREVIEW_PANEL_NAME.orn_view,
  [2] = PREVIEW_PANEL_NAME.ability_view,
  [3] = PREVIEW_PANEL_NAME.equation_view
}
local TOG_NAME_LIST = {
  [PREVIEW_PANEL_NAME.orn_view] = "奇珍",
  [PREVIEW_PANEL_NAME.ability_view] = "片语",
  [PREVIEW_PANEL_NAME.equation_view] = "融合片段"
}

function ui:on_click_BtnRet1()
  self:ui_hide()
end

function ui:on_select_func_tog(panel_name, isOn)
  self.v_panel_name_to_tog[panel_name].interactable = not isOn
  local preview_data = isOn and self.v_preview_data_map[panel_name]
  self.v_panels[panel_name]:set_enable(isOn, preview_data, self.v_main_sect)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:register_exist_auto_template(PREVIEW_FUNC_TEMP_KEY, self.v_uiobjects.FunTog1, self.v_uiobjects.FunctionList)
end

function ui:ui_on_show(init_view_name, preview_data_map, main_sect)
  self.v_panel_name_to_tog = {}
  for i = 1, #TOG_PANEL_NAME do
    local panel_name = TOG_PANEL_NAME[i]
    local obj = self:get_auto_cache(PREVIEW_FUNC_TEMP_KEY)
    local name = self:get_text("PageName", obj)
    name.text = TOG_NAME_LIST[panel_name]
    local toggle = self:get_toggle(nil, obj)
    self.v_panel_name_to_tog[panel_name] = toggle
    self:set_toggle_listener(toggle, function(isOn)
      self:on_select_func_tog(panel_name, isOn)
    end)
  end
  self.v_main_sect = main_sect
  self.v_preview_data_map = preview_data_map
  init_view_name = init_view_name and self.v_panel_name_to_tog[init_view_name] and init_view_name or TOG_PANEL_NAME[1]
  self.v_panel_name_to_tog[init_view_name].isOn = false
  self.v_panel_name_to_tog[init_view_name].isOn = true
end

function ui:ui_on_hide()
  for _, panel in pairs(self.v_panels) do
    panel:set_enable(false)
  end
end

function ui:ui_on_destroy()
end

return ui
