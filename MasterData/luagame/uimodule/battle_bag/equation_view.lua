local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local EQUATION_ITEM = require("uimodule.stage_activity.fate_book.equation_item")
local EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY = "EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY"

function ui:ui_finish_load()
  EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY = EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY .. self.v_parent_ui:ui_get_name()
  self:register_exist_auto_template(EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY, self.v_uiobjects.EquationTem, self.v_uiobjects.EquationList)
  self.v_equation_item_map = {}
end

function ui:ui_on_show(preview_data, main_sect)
  self.v_main_sect = main_sect
  self.v_preview_data = preview_data
  self:refresh_view()
end

function ui:ui_on_hide()
  self:clear_equation_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  self:clear_equation_item()
  local equation_data_map = self.v_preview_data or FateBookMgr:get_equation_data_map()
  local build_data
  for equation_id, equation_data in pairs(equation_data_map) do
    local obj = self:get_auto_cache(EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY)
    self.v_equation_item_map[equation_id] = EQUATION_ITEM:ui_wrap_ex(self, obj, true)
    build_data = {
      equation_id = equation_id,
      level = equation_data.level,
      branch_id = equation_data.branch_id,
      key = equation_id,
      ability_count_map = equation_data.ability_count_map
    }
    self.v_equation_item_map[equation_id]:set_data(build_data, true, true, ccd.EQUATION_OPERATION_TYPE.PAUSE_VIEW)
  end
end

function ui:clear_equation_item()
  self:give_back_auto_cache(EQUATIONCONTENT_EQUATIONTEM_TEMP_KEY)
  for key, equation_item in pairs(self.v_equation_item_map) do
    equation_item:ui_hide()
    equation_item:ui_destroy()
    self.v_equation_item_map[key] = nil
  end
end

return ui
