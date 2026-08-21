local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)

function M:_init(parent_ui, self_gameobj, ITEM_CLASS, template_key)
  self.v_parent_ui = parent_ui
  self.self_gameobj = self_gameobj
  self.v_self_transform = self_gameobj.transform
  self.v_self_rect_trans = Util.get_rect_transform(nil, self_gameobj)
  self.v_item_class = ITEM_CLASS
  self.v_slider = Util.get_slider(nil, self.v_self_transform:GetChild(0).gameObject)
  self.v_item_template_key = template_key
  self.v_item_template = self.v_self_transform:GetChild(1).gameObject
  parent_ui:register_exist_auto_template(template_key, self.v_item_template, self_gameobj)
  self.v_item_count = 0
  self.v_items = {}
end

local function _get_item(self)
  local obj = self.v_parent_ui:get_auto_cache(self.v_item_template_key)
  local item = self.v_item_class:ui_wrap_ex(nil, obj)
  item.go = obj
  return item
end

local function _add_item(self, data, index, length)
  local item = _get_item(self)
  local item_gameobj = item.go
  local item_trans = item_gameobj.transform
  item_trans:SetParent(self.v_self_transform)
  self.v_item_count = self.v_item_count + 1
  if item.set_data then
    item:set_data(data, self)
  end
  table.insert(self.v_items, item)
  item_gameobj:SetActive(true)
  local rect_transform = Util.get_rect_transform(nil, item_gameobj)
  local pos_x = index / length * self.v_width
  local pos_y = rect_transform.anchoredPosition.y
  rect_transform:SetAnchoredPositionA(pos_x, pos_y)
end

function M:clear()
  for _, item in ipairs(self.v_items) do
    item:on_clear()
    self.v_parent_ui:give_back_auto_cache(self.v_item_template_key)
  end
  UtilTable.clear_list(self.v_items)
  self.v_item_count = 0
end

function M:update_list(item_data_list, progress_value)
  self.v_width = self.v_self_rect_trans.rect.width
  self:clear()
  if not item_data_list then
    return
  end
  local length = #item_data_list
  for i = 1, length do
    _add_item(self, item_data_list[i], i, length)
  end
  progress_value = progress_value or 0
  self.v_slider.value = progress_value
  local slider_fill_obj = Util.get_child_gameobj("SliderFill", self.v_slider.gameObject)
  slider_fill_obj:SetActive(progress_value > 0)
end

return M
