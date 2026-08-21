local Base = require("ui.widget.infinite_loop_list")
local M = Util.create_child_mt(Base)
local right_padding = 61

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
  item_ui:set_data(self.v_data[index], index, self.v_bag_type)
  if index == src_idx and self.is_stop == false then
    if index > 16 then
      return
    end
    local item_canvas = item.gameObject:GetComponent("CanvasGroup")
    if item_canvas then
      item_canvas.alpha = 0
      local sequence = Util.create_sequence()
      if math.floor((index - 1) / 4) > 0 then
        sequence:AppendInterval(math.floor((index - 1) / 4) * 0.1)
      end
      sequence:Append(item_canvas:DOFade(1, 0.4))
      table.insert(self.v_sequences, sequence)
    end
  end
end

function M:refresh_data(list, bag_type, stop_dynamic_effect)
  self.v_bag_type = bag_type
  if nil == stop_dynamic_effect or false == stop_dynamic_effect then
    self.is_stop = false
  else
    self.is_stop = true
  end
  if self.v_sequences then
    for k, sequence in pairs(self.v_sequences) do
      sequence:Kill(false)
      sequence = nil
    end
  end
  self.v_sequences = {}
  self:setColNum()
  Base.refresh_data(self, list)
end

function M:setColNum()
  local content_width = self.v_scrollret.content.rect.width
  local cell_width = self.v_scrollviewex.m_CellTemplateTrans.rect.width
  local spacingX = self.v_scrollviewex.spacing.x
  self.v_scrollviewex.colNum = math.floor((content_width + spacingX) / (cell_width + spacingX))
  local rest_width = (content_width + spacingX) % (cell_width + spacingX) - right_padding
  local new_spacing = UnityVector2(spacingX + rest_width / (self.v_scrollviewex.colNum - 1), self.v_scrollviewex.spacing.y)
  local cellSize = self.v_scrollviewex.m_CellTemplateTrans.rect.size
  self.v_scrollviewex.SizeCell = UnityVector2(cellSize.x + new_spacing.x, cellSize.y + new_spacing.y)
end

return M
