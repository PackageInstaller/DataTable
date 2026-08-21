local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local event_system = UnityEngine.EventSystems
local event_trigger = event_system.EventTrigger
local event_entry = event_trigger.Entry
local _mfloor = math.floor

local function cal_start_y(len, cell_size_y, mid_y)
  local create_num = _mfloor(len / 2)
  local start_pos = mid_y + create_num * cell_size_y
  return start_pos
end

local function cal_content_y(len, cell_size_y, content_mid_y)
  local create_num = _mfloor(len / 2)
  local content_start_pos = content_mid_y - create_num * cell_size_y
  return content_start_pos
end

function M:_init(parent_ui, content_gameobj, template_class, template_key)
  self.v_content_gameobj = content_gameobj
  self.v_content_transform = content_gameobj.transform
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_content_gameobj)
  self.v_parent_ui = parent_ui
  self.v_content_mid_y = self.v_content_rect_trans.anchoredPosition.y
  self.v_content_mid_x = self.v_content_rect_trans.anchoredPosition.x
  local child_obj = content_gameobj.transform:GetChild(0).gameObject
  local child_obj_tran = child_obj.transform
  local cell_size_y = child_obj_tran.sizeDelta.y
  self.v_mid_pos_y = child_obj_tran.anchoredPosition.y
  self.v_mid_pos_x = child_obj_tran.anchoredPosition.x
  self.v_cell_size_x = child_obj_tran.sizeDelta.x
  self.v_cell_size_y = cell_size_y
  self.v_template_key = template_key
  self.v_template = child_obj
  self.ItemClass = template_class
  parent_ui:register_exist_auto_template(template_key, child_obj, self.v_content_gameobj)
  self.v_item_count = 0
  self.v_items = {}
  self.v_pos2item = {}
  self.v_select_item = nil
end

function M:reset_position()
  self.v_content_rect_trans:SetAnchoredPositionA(self.v_content_mid_x, self.v_content_mid_y)
end

function M:refresh_data(data_list)
  self:reset_position()
  local mid_pos_y = self.v_mid_pos_y
  local cell_size_y = self.v_cell_size_y
  local list_len = #data_list
  local len = list_len * 2
  self.v_item_count = len
  self.v_select_item = nil
  self.v_group_y_num = len * cell_size_y
  self.v_top = 1
  self.v_bottom = len
  self.v_top_red_line = mid_pos_y + cell_size_y
  self.v_bottom_red_line = mid_pos_y - cell_size_y
  self.v_interal = len * cell_size_y
  self.v_start_y = cal_start_y(len, cell_size_y, mid_pos_y)
  self.v_content_start_y = cal_content_y(len, cell_size_y, self.v_content_mid_y)
  local start_y = self.v_start_y
  self.v_parent_ui:give_back_auto_cache(self.v_template_key)
  for i = 1, len do
    local mod_num = i % list_len
    local idx = 0 == mod_num and list_len or mod_num
    self:create_obj(self.v_parent_ui, self.v_template_key, start_y, i, cell_size_y, data_list[idx])
  end
  self:_init_content_event()
  self:on_select()
end

function M:_init_content_event()
  local trigger = Util.get_component(nil, self.v_content_gameobj, event_trigger)
  self.v_trigger_com = trigger
  self.v_pre_y = nil
  self.v_speed = 0.5
  self.v_now_y = nil
  local list_rect = Util.get_rect_transform(nil, self.v_content_gameobj)
  self:begin_drag()
  self:on_draging(list_rect)
  self:end_drag(list_rect)
end

function M:begin_drag()
  local entrybegindrag = event_entry()
  entrybegindrag.eventID = Config.EVENT_TRIGGER_TYPE.BeginDrag
  entrybegindrag.callback:AddListener(function(data)
    local y = data.position.y
    self.v_pre_y = y
    self.v_now_y = y
  end)
  self.v_trigger_com.triggers:Add(entrybegindrag)
end

function M:on_draging(list_rect)
  local entrydrag = event_entry()
  entrydrag.eventID = Config.EVENT_TRIGGER_TYPE.Drag
  entrydrag.callback:AddListener(function(data)
    local y = data.position.y
    local yoffset = (y - self.v_pre_y) * self.v_speed
    local listy = list_rect.anchoredPosition.y
    local listx = list_rect.anchoredPosition.x
    list_rect:SetAnchoredPositionA(listx, listy + yoffset)
    self.v_pre_y = y
    self:play_dynamic_effect()
    listy = list_rect.anchoredPosition.y
    if listy > self.v_top_red_line then
      local count = math.ceil(yoffset / self.v_cell_size_y)
      for i = 1, count do
        local now_item = self.v_items[self.v_top].go
        self.v_top_red_line = self.v_top_red_line + self.v_cell_size_y
        self.v_bottom_red_line = self.v_bottom_red_line + self.v_cell_size_y
        self.v_now_y = y
        now_item.transform:SetAsLastSibling()
        local item_rect = Util.get_rect_transform(nil, now_item)
        local item_rect_x = item_rect.anchoredPosition.x
        local item_rect_y = item_rect.anchoredPosition.y
        item_rect:SetAnchoredPositionA(item_rect_x, item_rect_y - self.v_interal)
        local add_top = (self.v_top + 1) % self.v_item_count
        local add_bottom = (self.v_bottom + 1) % self.v_item_count
        self.v_top = 0 == add_top and self.v_item_count or add_top
        self.v_bottom = 0 == add_bottom and self.v_item_count or add_bottom
      end
    elseif listy < self.v_bottom_red_line then
      local count = math.ceil(-1 * yoffset / self.v_cell_size_y)
      for i = 1, count do
        local now_item = self.v_items[self.v_bottom].go
        self.v_top_red_line = self.v_top_red_line - self.v_cell_size_y
        self.v_bottom_red_line = self.v_bottom_red_line - self.v_cell_size_y
        self.v_now_y = y
        now_item.transform:SetAsFirstSibling()
        local item_rect = Util.get_rect_transform(nil, now_item)
        local item_rect_x = item_rect.anchoredPosition.x
        local item_rect_y = item_rect.anchoredPosition.y
        item_rect:SetAnchoredPositionA(item_rect_x, item_rect_y + self.v_interal)
        local sub_top = (self.v_top - 1) % self.v_item_count
        local sub_bottom = (self.v_bottom - 1) % self.v_item_count
        self.v_top = 0 == sub_top and self.v_item_count or sub_top
        self.v_bottom = 0 == sub_bottom and self.v_item_count or sub_bottom
      end
    end
  end)
  self.v_trigger_com.triggers:Add(entrydrag)
end

function M:end_drag()
  local entry_end_drag = event_entry()
  entry_end_drag.eventID = Config.EVENT_TRIGGER_TYPE.EndDrag
  entry_end_drag.callback:AddListener(function()
    self:on_select()
  end)
  self.v_trigger_com.triggers:Add(entry_end_drag)
end

function M:create_obj(parent_ui, template_key, start_y, idx, cell_size_y, data)
  local obj = parent_ui:get_auto_cache(template_key)
  local obj_trans = obj.transform
  local x = obj_trans.anchoredPosition.x
  local y = start_y - (idx - 1) * cell_size_y
  local cotent_y = self.v_content_start_y + (idx - 1) * cell_size_y
  if cotent_y < 0 then
    cotent_y = cotent_y + self.v_group_y_num
  end
  obj_trans:SetAnchoredPositionA(x, y)
  obj.name = "item" .. idx
  local item = self.ItemClass:ui_wrap(nil, obj)
  item.go = obj
  obj:SetActive(true)
  self.v_items[idx] = item
  item:set_data(data)
  self.v_pos2item[cotent_y] = item
end

function M:clear()
  for _, trigger_event in pairs(self.v_trigger_com.triggers) do
    trigger_event.callback:RemoveAllListeners()
  end
  self.v_trigger_com.triggers:Clear()
  for _, item in pairs(self.v_items) do
    item:on_clear()
    item:ui_hide(true)
    item:ui_destroy()
  end
  self.v_parent_ui:give_back_auto_cache(self.v_template_key)
  UtilTable.clear_list(self.v_items)
  UtilTable.clear_map(self.v_pos2item)
  self.v_item_count = 0
end

function M:on_select()
  local item, listx, real_y = self:get_select_item_info()
  self.v_content_rect_trans:SetAnchoredPositionA(listx, real_y)
  self.v_select_item = item
  self.v_select_item:set_selected()
end

function M:play_dynamic_effect()
  local select_item = self:get_select_item_info()
  select_item:set_text_select()
  for k, value in pairs(self.v_items) do
    if value.go.transform.name ~= select_item.go.transform.name then
      value:set_text_unselect()
    end
  end
end

function M:get_select_item_info()
  local list_rect = Util.get_rect_transform(nil, self.v_content_gameobj)
  local listy = list_rect.anchoredPosition.y
  local listx = list_rect.anchoredPosition.x
  local offset_y = _mfloor(self.v_cell_size_y / 2)
  local num = _mfloor((listy + offset_y - self.v_content_mid_y) / self.v_cell_size_y)
  local real_y = num * self.v_cell_size_y + self.v_content_mid_y
  local relative_y = real_y % self.v_group_y_num
  local item = self.v_pos2item[relative_y]
  return item, listx, real_y
end

return M
