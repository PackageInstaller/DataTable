local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local CSHelper = _ENV.CSHelper

function M:_init(parent_ui, content_gameobj, template_class, constraint_count, template_key)
  self.v_content_gameobj = content_gameobj
  self.v_content_transform = content_gameobj.transform
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_content_gameobj)
  self.v_content_cpt = Util.get_component(nil, content_gameobj, typeof(UnityEngine.UI.GridLayoutGroup))
  self.v_content_size = self.v_content_cpt.cellSize
  self.v_constraint_count = constraint_count
  local template = content_gameobj.transform:GetChild(0).gameObject
  self.v_template_key = template_key
  self.v_template = template
  self.v_parent_ui = parent_ui
  self.ItemClass = template_class
  parent_ui:register_exist_auto_template(template_key, template, self.v_content_gameobj)
  self.v_items = {}
end

function M:get_item()
  local obj = self.v_parent_ui:get_auto_cache(self.v_template_key)
  local item = self.ItemClass:ui_wrap(nil, obj)
  item.go = obj
  return item
end

function M:push_item(data)
  self:add_item(data)
end

function M:add_item(data, i)
  local item = self:get_item()
  local item_gameobj = item.go
  item_gameobj.transform:SetParent(self.v_content_transform)
  CSHelper.ResetGameObjectLocalAttr(item_gameobj)
  local rect_transform = Util.get_rect_transform(nil, item_gameobj)
  rect_transform:SetAnchoredPositionA(0, -self.v_item_count * self.v_content_size.y)
  self.v_item_count = self.v_item_count + 1
  if item.set_data then
    item:set_data(data, self)
  end
  item.rect_trans = rect_transform
  table.insert(self.v_items, item)
  item_gameobj:SetActive(true)
end

function M:update_list(res_list)
  self:clear()
  if not res_list then
    return
  end
  for i = 1, #res_list do
    if 0 ~= res_list[i] then
      self:add_item(res_list[i], i)
    end
  end
end

function M:update_filt_type(flit_arg)
  for _, item in ipairs(self.v_items) do
    self:update_filt_type(flit_arg)
  end
end

function M:on_select_change(selected_item)
  local list = self.v_items
  for i = 1, #list do
    list[i]:set_selected(list[i] == selected_item)
  end
end

function M:clear()
  for _, item in ipairs(self.v_items) do
    item:on_clear()
    self.v_parent_ui:give_back_auto_cache(self.v_template_key)
  end
  UtilTable.clear_list(self.v_items)
  self.v_item_count = 0
end

function M:refresh_items()
  for _, item in ipairs(self.v_items) do
    item:on_refresh()
  end
end

function M:set_enable(param)
  self.v_content_gameobj:SetActiveEx(param)
end

function M:on_update()
end

return M
