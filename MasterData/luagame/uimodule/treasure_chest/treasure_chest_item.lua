local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_item_icon = {
    "ItemIcon",
    BIND_TYPE.IMAGE
  },
  v_item_quality = {
    "ItemQuality",
    BIND_TYPE.IMAGE
  },
  v_item_choose = {
    "Choose",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_tog = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(self.v_tog, function(isOn)
    self:on_click_tog(isOn)
  end)
end

function ui:ui_on_show(cfg, ...)
end

function ui:ui_on_hide()
end

function ui:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function ui:set_data(item, data_list, index)
  if self.v_tog.isOn then
    self.v_item_choose:SetActive(index == self.select_index)
  end
  self.index = index
  self.data = data_list[index]
  ResMgr:load_set_icon(self.v_item_icon, UtilUI.get_item_icon(self.data.item_cfg.Id))
  ResMgr:load_set_icon(self.v_item_quality, UtilUI.get_item_quality_icon(self.data.item_cfg.Id))
end

function ui:on_click_tog(isOn)
  if not isOn then
    return
  end
  self.select_index = self.index
  self.v_linked_parent:refresh_right_info(self.data.item_cfg, self.data.treasure_chest_cfg, self.data.info, self.index)
  self.v_item_choose:SetActive(true)
end

function ui:force_onclick()
  self.v_tog.isOn = true
  self:on_click_tog(true)
end

return ui
