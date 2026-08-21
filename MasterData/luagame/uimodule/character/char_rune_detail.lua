local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local RUNE_DESC_ITEM_KEY = "RUNE_DESC_ITEM_KEY"

function ui:ui_finish_load()
  self:set_button("BtnColse", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(RUNE_DESC_ITEM_KEY, self.v_uiobjects.DescTem, self.v_uiobjects.DescContent)
end

function ui:ui_on_show()
  self.v_show_item_list = {}
  self.v_desc_cfg_list = ShareRes.create("buddy.rune_skill_explain")
  self:update_pnl()
end

function ui:update_pnl()
  self:remove_wrap_list()
  for index, data in ipairs(self.v_desc_cfg_list) do
    local item = self:get_auto_cache(RUNE_DESC_ITEM_KEY)
    self:set_item_data(item, data)
    table.insert(self.v_show_item_list, item)
  end
end

function ui:set_item_data(item, data)
  local title = Util.get_text("Title", item)
  local desc = Util.get_text("Desc", item)
  title.text = data.Title
  desc.text = data.Desc
end

function ui:ui_on_hide()
  self:remove_wrap_list()
end

function ui:remove_wrap_list()
  for _, obj in pairs(self.v_show_item_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_show_item_list = {}
end

return ui
