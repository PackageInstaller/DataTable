local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)

function M:_init(parent_ui, scroll_gameobj, template_class, top_cb, buttom_cb)
  self.v_parent_ui = parent_ui
  self.v_scroll_gameobj = scroll_gameobj
  self.v_dynamicscroll = scroll_gameobj:GetComponent(typeof(CS.Game.DynamicScorll))
  assert(self.v_dynamicscroll, "should have ScrollViewEx component !!")
  
  function self.v_dynamicscroll.onSetFunc(obj, index, src_idx)
    self:_update_scrollview_cell(obj, index, src_idx)
  end
  
  function self.v_dynamicscroll.onSlider2Top()
    if top_cb then
      top_cb()
    end
  end
  
  function self.v_dynamicscroll.onSlider2Bottom()
    if buttom_cb then
      buttom_cb()
    end
  end
  
  self.ItemClass = template_class
  self.v_data = nil
  self.v_items = {}
end

function M:refresh_data(list)
  self:_clear_uis()
  self.v_data = list
  self.v_dynamicscroll.totalCount = #list
end

function M:add_data(list)
  self.v_data = list
  self.v_dynamicscroll:AddItems(#self.v_data - self.v_dynamicscroll.totalCount)
end

function M:_update_scrollview_cell(item, index, src_idx)
  index = index + 1
  src_idx = src_idx + 1
  local item_ui
  if index == src_idx then
    if self.v_items[index] == nil then
      item_ui = self.ItemClass:ui_wrap(nil, item, true)
      self.v_items[index] = item_ui
    else
      item_ui = self.v_items[index]
    end
  else
    item_ui = self.v_items[src_idx]
    if nil == item_ui then
      Log.Error("没有找到序号scr_idx=", src_idx, "的ui对象！")
    end
    self.v_items[index] = item_ui
    self.v_items[src_idx] = nil
  end
  item:SetActiveEx(false)
  if index > #self.v_data then
    return
  end
  item:SetActiveEx(true)
  item_ui:set_data(item, self.v_data, index)
end

function M:scroll_to_item(index)
  self.v_dynamicscroll:ScrollToItem(index)
end

function M:scroll_to_bottom()
  self.v_dynamicscroll:ScrollToBottom()
end

function M:get_visual_end_idx()
  return self.v_dynamicscroll:GetVisualEndIdx()
end

function M:_clear_uis()
  if self.v_items ~= nil and nil ~= next(self.v_items) then
    for k, v in pairs(self.v_items) do
      v:ui_hide(true)
      v:ui_destroy()
    end
  end
  self.v_items = {}
end

function M:ui_on_hide()
  self:_clear_uis()
end

function M:ui_on_destroy()
  self:_clear_uis()
  self.v_items = nil
  if self.v_dynamicscroll then
    self.v_dynamicscroll:ClearCells()
  end
end

return M
