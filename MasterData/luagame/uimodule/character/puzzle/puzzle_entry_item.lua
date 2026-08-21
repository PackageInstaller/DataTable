local Base = require("ui.uiobject")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local TEMPLATE_KEY_PUZZLE_ITEM = "PUZZLE_ENTRY_ITEM_TEMPLATE_KEY_PUZZLE_ITEM"
local PuzzleItemClass = require("uimodule.character.puzzle.puzzle_item")
local M = Util.create_child_mt(Base)

function M:ui_finish_load()
  self.v_btn = Util.get_button(nil, self.v_object)
  self:set_button("BtnTitle", function()
    local is_active = self.v_uiobjects.PluginsContent.activeSelf
    self:set_list_show(not is_active)
  end)
end

function M:check_register_template(id)
  if not self.v_temp_key then
    self.v_temp_key = TEMPLATE_KEY_PUZZLE_ITEM .. id
    self:register_exist_auto_template(self.v_temp_key, self.v_uiobjects.PluginsTem, self.v_uiobjects.PluginsContent)
  end
end

function M:set_list_show(is_active)
  local is_empty = self.v_entry_item_list and 0 == #self.v_entry_item_list
  if not is_empty and is_active then
    self:refresh_puzzle_list()
  end
  self.v_uiobjects.PluginsContent:SetActive(is_active and not is_empty)
  self:update_arrow()
end

function M:ui_on_show()
  self.v_uiobjects.PluginsContent:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_LIST_UPDATE, self.on_puzzle_list_update, self)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_ITEM_UPDATE, self.on_data_update, self)
end

function M:ui_on_hide()
  self.v_temp_key = nil
  self:clear_wrap_items()
  self.v_data = nil
  self:unregister_all_auto_template()
end

function M:on_puzzle_list_update(msg)
  if not self.v_visible then
    return
  end
  local is_active_content = self.v_uiobjects.PluginsContent.activeSelf
  if is_active_content then
    self:set_list_show(true)
  end
end

function M:on_data_update(msg)
  if not self.v_visible then
    return
  end
  if self.v_data and msg.mm_x == self.v_data.uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(msg.mm_x)
    self.v_data.buddy_id = puzzle_data.buddy_id
    self.v_data.quality = puzzle_data.quality
    self:update_arrow()
  end
end

function M:clear_wrap_items()
  if self.v_entry_item_list then
    for idx = #self.v_entry_item_list, 1, -1 do
      local item = self.v_entry_item_list[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_entry_item_list[idx] = nil
    end
  end
end

function M:refresh_puzzle_list()
  self:clear_wrap_items()
  local all_puzzle_data = PuzzleMgr:get_all_puzzle_data()
  if not all_puzzle_data then
    return
  end
  local is_lv_page = self.v_filter_puzzle_id ~= nil
  local filter_puzzle_id, filter_uuid_id, filter_attr_map
  if is_lv_page then
    filter_puzzle_id = self.v_filter_puzzle_id
    filter_uuid_id = self.v_filter_uuid_id
    filter_attr_map = self.v_filter_attr_map
  end
  local puzzle_list = {}
  for _, data in pairs(all_puzzle_data) do
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(data.id)
    local _graph_id = puzzle_cfg.GraphID
    if self.v_entry_id == puzzle_cfg.EntryId then
      local _data = UtilTable.copy_table(data)
      _data.buddy_id = _data.buddy_id or 0
      _data.graph_id = _graph_id
      _data.filter_puzzle_id = filter_puzzle_id
      _data.is_lvup_operating = filter_uuid_id == data.uuid
      _data.show_ban_mask = false
      if is_lv_page and filter_uuid_id then
        if filter_uuid_id == data.uuid then
          _data.lv_page_order = 1
          _data.show_ban_mask = true
        elseif filter_puzzle_id == data.id then
          if data.quality == Config.PUZZLE_MIN_QUALITY then
            if self:check_attr_at_map(data, filter_attr_map) then
              _data.show_ban_mask = true
              _data.lv_page_order = 3
            else
              _data.lv_page_order = 2
            end
          else
            _data.show_ban_mask = true
            _data.lv_page_order = 4
          end
        else
          _data.show_ban_mask = true
          _data.lv_page_order = 5
        end
      end
      puzzle_list[#puzzle_list + 1] = _data
    end
  end
  table.sort(puzzle_list, function(dataA, dataB)
    if dataA.lv_page_order and dataA.lv_page_order ~= dataB.lv_page_order then
      return dataA.lv_page_order < dataB.lv_page_order
    end
    if dataA.buddy_id ~= dataB.buddy_id then
      if 0 == dataA.buddy_id then
        return true
      end
      if 0 == dataB.buddy_id then
        return false
      end
    end
    if dataA.quality ~= dataB.quality then
      return dataA.quality > dataB.quality
    end
    if dataA.id ~= dataB.id then
      return dataA.id < dataB.id
    end
    return dataA.uuid < dataB.uuid
  end)
  self:give_back_auto_cache(self.v_temp_key)
  self.v_entry_item_list = {}
  for _, data in ipairs(puzzle_list) do
    data.filter_puzzle_id = self.v_filter_puzzle_id
    data.filter_uuid_id = self.v_filter_uuid_id
    local item = self:get_auto_cache(self.v_temp_key)
    local item_lua_obj = PuzzleItemClass:ui_wrap_ex(self, item, true)
    item_lua_obj:set_linked_parent(self.v_parent_ui)
    item_lua_obj:set_data_ex(data)
    table.insert(self.v_entry_item_list, item_lua_obj)
  end
end

function M:set_data(entry_id, filter_puzzle_id, filter_uuid_id, filter_attr_map)
  self:check_register_template(entry_id)
  self.v_entry_id = entry_id
  self.v_filter_puzzle_id = filter_puzzle_id
  self.v_filter_uuid_id = filter_uuid_id
  self.v_filter_attr_map = filter_attr_map
  local entry_cfg = ShareRes.create("buddy.buddy_puzzle_entry")[self.v_entry_id]
  self.v_uicompents.EffectName_txt.text = entry_cfg[next(entry_cfg)].Name
  local is_active = self.v_parent_ui:get_entry_show_mark(self.v_entry_id)
  self:set_list_show(is_active)
  if not is_active then
    self:update_arrow()
  end
end

function M:update_arrow()
  local own_puzzle_num = PuzzleMgr:get_own_puzzle_num_by_entry(self.v_entry_id)
  self.v_uiobjects.ArrowNoItem:SetActive(0 == own_puzzle_num)
  self.v_uiobjects.Arrow:SetActive(own_puzzle_num > 0)
  local is_active_content = self.v_uiobjects.PluginsContent.activeSelf
  if own_puzzle_num > 0 then
    self.v_uicompents.Arrow_rect:SetLocalEuler(0, 0, is_active_content and 0 or -90)
  end
  self.v_parent_ui:set_entry_show_mark(self.v_entry_id, is_active_content)
end

function M:check_attr_at_map(puzzle_data, filter_map)
  local attr_list = puzzle_data.attr_list
  if attr_list and filter_map then
    for index, id in ipairs(attr_list) do
      local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(id)
      local attr_id = attr_cfg.AttrId
      if filter_map[attr_id] then
        return true
      end
    end
  end
  return false
end

return M
