local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local _tsort = table.sort
local PuzzleHelper = require("uimodule.character.puzzle.puzzle_helper")
local CommonDefine = require("cs_share.common_define")
local RELIC_ENTRY_TYPE = CommonDefine.RELIC_ENTRY_TYPE
local Timer = Global.timer
local SORT_TYPE = {
  quality = 1,
  lv = 2,
  time = 3
}
local SORT_RULE = {
  [SORT_TYPE.quality] = {
    "quality",
    "lv",
    "id"
  },
  [SORT_TYPE.lv] = {
    "lv",
    "quality",
    "id"
  },
  [SORT_TYPE.time] = {
    "time",
    "quality",
    "lv",
    "id"
  }
}
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.v_all_puzzle_map = {}
  self.v_buddy_relic_map = {}
  self:reset_filter()
end

function M:on_reconnect()
  self.v_all_relic_map = {}
  self.v_buddy_relic_map = {}
  self:reset_filter()
end

function M:reset_filter()
  self.v_is_drop = false
  self.v_sort_type = SORT_TYPE.quality
  self.v_filter_slot = nil
  self.v_filter_quality = nil
  self.v_filter_attr = nil
  self.v_filter_suit = nil
  self.v_filter_exclude_uuid = nil
  self.v_filter_include_exp_item = nil
end

function M:on_gs2c_puzzle_list(data)
  self.v_puzzle_map = data.puzzles
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_LIST_UPDATE)
end

function M:on_gs2c_puzzle_batch_update(data_list)
  local uuid
  local count = 0
  for _, puzzle in pairs(data_list.puzzles) do
    self.v_puzzle_map[puzzle.uuid] = puzzle
    count = count + 1
    uuid = puzzle.uuid
  end
  if count > 1 then
    MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_LIST_UPDATE)
  else
    local msg = MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_ITEM_UPDATE)
    msg.mm_x = uuid
  end
end

function M:on_gs2c_puzzle_update(data)
  local uuid = data.puzzle.uuid
  local old_data = self.v_puzzle_map[uuid]
  self.v_puzzle_map[uuid] = data.puzzle
  if old_data then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_ITEM_UPDATE)
    msg.mm_x = uuid
  else
    MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_LIST_UPDATE)
  end
end

function M:on_gs2c_puzzle_delete(data)
  for _, uuid in ipairs(data.uuid) do
    self.v_puzzle_map[uuid] = nil
  end
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_LIST_UPDATE)
end

function M:install_puzzle(uuid, rotate_count, position, buddy_id)
  Network:protect_call("c2gs_puzzle_place_in", {
    place_in = {
      uuid = uuid,
      rotate_count = rotate_count,
      position = position,
      buddy_id = buddy_id
    }
  }, function(ok, resp)
  end)
end

function M:batch_install_puzzle(data_list, uninstall_buddy_id, callback)
  Network:protect_call("c2gs_puzzle_batch_place_in", {place_in_list = data_list, uninstall_buddy_id = uninstall_buddy_id}, function(ok, resp)
    if ok and #data_list > 0 then
      Util.show_message_tip(2076)
      MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_BATCH_SET)
    end
    if callback then
      callback(ok)
    end
  end)
end

function M:uninstall_puzzle(uuid, uuid_list)
  local uuid_list = uuid and {uuid} or uuid_list
  Network:protect_call("c2gs_puzzle_peel_off", {uuids = uuid_list}, function(ok, resp)
  end)
end

function M:decompose_puzzle(uuid_list, callback)
  Network:protect_call("c2gs_puzzle_decompose", {uuids = uuid_list}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:upgrade_puzzle(uuid, consume_uuid_list, callback)
  Network:protect_call("c2gs_puzzle_up_quality", {uuid = uuid, consume_uuid_list = consume_uuid_list}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:refine_puzzle(uuid, refresh_attr_list, callback)
  Network:protect_call("c2gs_puzzle_refresh_attr", {uuid = uuid, refresh_attr_list = refresh_attr_list}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:get_puzzle_data(uuid)
  if uuid and self.v_puzzle_map then
    return self.v_puzzle_map[uuid]
  end
end

function M:get_all_puzzle_data()
  return self.v_puzzle_map
end

function M:get_all_puzzle_data_list()
  local list = {}
  if self.v_puzzle_map then
    for _, v in pairs(self.v_puzzle_map) do
      _tinsert(list, UtilTable.copy_table(v))
    end
  end
  return list
end

function M:get_all_free_puzzle(exclude_buddy_id)
  local list = {}
  if self.v_puzzle_map then
    for _, v in pairs(self.v_puzzle_map) do
      if not v.buddy_id or 0 == v.buddy_id or v.buddy_id and v.buddy_id == exclude_buddy_id then
        _tinsert(list, UtilTable.copy_table(v))
        local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(v.id)
        list[#list].graph_id = puzzle_cfg.GraphID
      end
    end
  end
  return list
end

function M:get_own_puzzle_num_by_id(item_id)
  local num = 0
  if self.v_puzzle_map then
    for _, data in pairs(self.v_puzzle_map) do
      if item_id == data.id then
        num = num + 1
      end
    end
  end
  return num
end

function M:get_own_puzzle_num_by_entry(entry_id)
  local num = 0
  if self.v_puzzle_map then
    for _, data in pairs(self.v_puzzle_map) do
      local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(data.id)
      if entry_id == puzzle_cfg.EntryId then
        num = num + 1
      end
    end
  end
  return num
end

function M:get_own_puzzle_data_list_by_entry(entry_id)
  local list = {}
  if self.v_puzzle_map then
    for _, data in pairs(self.v_puzzle_map) do
      local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(data.id)
      if entry_id == puzzle_cfg.EntryId then
        list[#list + 1] = UtilTable.copy_table(data)
        list[#list].graph_id = puzzle_cfg.GraphID
      end
    end
  end
  table.sort(list, function(a, b)
    if a.graph_id ~= b.graph_id then
      return a.graph_id > b.graph_id
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    return a.uuid < b.uuid
  end)
  return list
end

function M:try_remove_puzzle(uuid, buddy_id)
  local data = self:get_puzzle_data(uuid)
  if data and data.buddy_id == buddy_id then
    self:uninstall_puzzle(uuid)
    return true
  end
end

function M:remove_buddy_all_puzzle(buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  local puzzle_place_infos = buddy_info.puzzle_graph.puzzle_place_infos
  local puzzle_uuid_list = {}
  if puzzle_place_infos then
    for _, puzzle_place_info in pairs(puzzle_place_infos) do
      puzzle_uuid_list[#puzzle_uuid_list + 1] = puzzle_place_info.uuid
    end
  end
  if #puzzle_uuid_list > 0 then
    local function confirm_cb()
      self:uninstall_puzzle(nil, puzzle_uuid_list)
    end
    
    Util.show_notify_popup_message(confirm_cb, "是否卸下全部古痕？")
  end
end

function M:auto_set_puzzle(buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  local puzzle_graph = buddy_info.puzzle_graph
  local map_graph_id = puzzle_graph.id
  if not map_graph_id or 0 == map_graph_id then
    return false
  end
  local hex_to_puzzle_id = {}
  for idx, node_data in ipairs(puzzle_graph.puzzle_place_infos) do
    local anchor_hex_pos = node_data.position
    local graph_hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos_by_puzzle_id(node_data.id, node_data.rotate_count)
    for _, relative_hex_pos in ipairs(graph_hex_pos_list) do
      local real_hex_x = anchor_hex_pos[1] + relative_hex_pos[1]
      local real_hex_y = anchor_hex_pos[2] + relative_hex_pos[2]
      if not hex_to_puzzle_id[real_hex_x] then
        hex_to_puzzle_id[real_hex_x] = {}
      end
      hex_to_puzzle_id[real_hex_x][real_hex_y] = node_data.uuid
    end
  end
  local map_hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(map_graph_id, 0)
  for _, node_hex_pos in ipairs(map_hex_pos_list) do
    hex_to_puzzle_id[node_hex_pos[1]] = hex_to_puzzle_id[node_hex_pos[1]] or {}
    hex_to_puzzle_id[node_hex_pos[1]][node_hex_pos[2]] = hex_to_puzzle_id[node_hex_pos[1]][node_hex_pos[2]] or 0
  end
  local all_free_puzzle = self:get_all_free_puzzle()
  table.sort(all_free_puzzle, function(a, b)
    if a.graph_id ~= b.graph_id then
      return a.graph_id > b.graph_id
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    if a.id ~= b.id then
      return a.id < b.id
    end
    return a.uuid < b.uuid
  end)
  local new_add_list = {}
  local wrong_graph_id
  for index, data in ipairs(all_free_puzzle) do
    if data.graph_id ~= wrong_graph_id then
      local hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(data.graph_id, 0)
      local graph_not_fit_anymore = true
      for _, node_hex in ipairs(map_hex_pos_list) do
        local is_graph_fit = true
        local move_hex_pos_list = PuzzleHelper.move_hex_node_group_to_target(hex_pos_list, node_hex)
        for _, move_hex_pos in ipairs(move_hex_pos_list) do
          if not hex_to_puzzle_id[move_hex_pos[1]] or 0 ~= hex_to_puzzle_id[move_hex_pos[1]][move_hex_pos[2]] then
            is_graph_fit = false
            break
          end
        end
        if is_graph_fit then
          graph_not_fit_anymore = false
          new_add_list[#new_add_list + 1] = {
            uuid = data.uuid,
            position = node_hex,
            rotate_count = 0,
            buddy_id = buddy_id
          }
          for _, move_hex_pos in ipairs(move_hex_pos_list) do
            hex_to_puzzle_id[move_hex_pos[1]] = hex_to_puzzle_id[move_hex_pos[1]] or {}
            hex_to_puzzle_id[move_hex_pos[1]][move_hex_pos[2]] = data.uuid
          end
          break
        end
      end
      if graph_not_fit_anymore then
        wrong_graph_id = data.graph_id
      end
    end
  end
  if #new_add_list > 0 then
    self:batch_install_puzzle(new_add_list)
    return true
  else
    Util.show_message_tip(2077)
  end
end

function M:is_any_free_puzzle_can_fit(buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  local puzzle_graph = buddy_info.puzzle_graph
  local map_graph_id = puzzle_graph.id
  if not map_graph_id or 0 == map_graph_id then
    return false
  end
  local hex_to_puzzle_id = {}
  for idx, node_data in ipairs(puzzle_graph.puzzle_place_infos) do
    local anchor_hex_pos = node_data.position
    local graph_hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos_by_puzzle_id(node_data.id, node_data.rotate_count)
    for _, relative_hex_pos in ipairs(graph_hex_pos_list) do
      local real_hex_x = anchor_hex_pos[1] + relative_hex_pos[1]
      local real_hex_y = anchor_hex_pos[2] + relative_hex_pos[2]
      if not hex_to_puzzle_id[real_hex_x] then
        hex_to_puzzle_id[real_hex_x] = {}
      end
      hex_to_puzzle_id[real_hex_x][real_hex_y] = node_data.uuid
    end
  end
  local map_hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(map_graph_id, 0)
  for _, node_hex_pos in ipairs(map_hex_pos_list) do
    hex_to_puzzle_id[node_hex_pos[1]] = hex_to_puzzle_id[node_hex_pos[1]] or {}
    hex_to_puzzle_id[node_hex_pos[1]][node_hex_pos[2]] = hex_to_puzzle_id[node_hex_pos[1]][node_hex_pos[2]] or 0
  end
  local all_free_puzzle = self:get_all_free_puzzle()
  local wrong_graph_id
  for _, data in ipairs(all_free_puzzle) do
    if data.graph_id ~= wrong_graph_id then
      local hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(data.graph_id, 0)
      local graph_not_fit_anymore = true
      for _, node_hex in ipairs(map_hex_pos_list) do
        local is_graph_fit = true
        local move_hex_pos_list = PuzzleHelper.move_hex_node_group_to_target(hex_pos_list, node_hex)
        for _, move_hex_pos in ipairs(move_hex_pos_list) do
          if not hex_to_puzzle_id[move_hex_pos[1]] or 0 ~= hex_to_puzzle_id[move_hex_pos[1]][move_hex_pos[2]] then
            is_graph_fit = false
            break
          end
        end
        if is_graph_fit then
          return true
        end
      end
      if graph_not_fit_anymore then
        wrong_graph_id = data.graph_id
      end
    end
  end
  return false
end

function M:reset_filter_record_shop()
  self.graph_map_filter_shop = nil
  self.entry_map_filter_shop = nil
  self.direct_up_shop = false
end

function M:check_filter_pass_shop(puzzle_id)
  local cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
  local graph_pass = not self.graph_map_filter_shop or self.graph_map_filter_shop[cfg.GraphID]
  local entry_pass = false
  if graph_pass then
    entry_pass = not self.entry_map_filter_shop or cfg.EntryId and self.entry_map_filter_shop[cfg.EntryId]
  end
  return entry_pass
end

function M:reset_filter_record(is_bag)
  if is_bag then
    self.graph_map_filter_bag = nil
    self.attr_map_filter_bag = nil
    self.entry_map_filter_bag = nil
    self.direct_up_bag = false
  else
    self.graph_map_filter = nil
    self.attr_map_filter = nil
    self.entry_map_filter = nil
  end
end

function M:get_puzzle_list_by_filter(is_bag, quality_filter)
  if is_bag then
    return self:get_puzzle_list_by_filter_ex(quality_filter, self.graph_map_filter_bag, self.attr_map_filter_bag, self.entry_map_filter_bag)
  else
    return self:get_puzzle_list_by_filter_ex(quality_filter, self.graph_map_filter, self.attr_map_filter, self.entry_map_filter)
  end
end

function M:get_puzzle_list_by_filter_ex(quality_filter, graph_map_filter, attr_map_filter, entry_map_filter)
  local list = {}
  if not self.v_puzzle_map then
    return list
  end
  for _, data in pairs(self.v_puzzle_map) do
    if not quality_filter or quality_filter == data.quality then
      local cfg = ShareRes.get_buddy_puzzle_cfg(data.id)
      local graph_pass = not graph_map_filter or graph_map_filter[cfg.GraphID]
      local attr_pass = false
      if graph_pass then
        if attr_map_filter then
          for _, attr_cfg_id in ipairs(data.attr_list) do
            local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
            local attr_id = attr_cfg.AttrId
            if attr_map_filter[attr_id] then
              attr_pass = true
              break
            end
          end
        else
          attr_pass = true
        end
      end
      local entry_pass = not entry_map_filter or cfg.EntryId and entry_map_filter[cfg.EntryId]
      if attr_pass and entry_pass then
        data.graph_id = cfg.GraphID
        list[#list + 1] = data
      end
    end
  end
  return list
end

function M:check_filter_suc(quality_filter, graph_map_filter, attr_map_filter, entry_map_filter)
  local list = self:get_puzzle_list_by_filter_ex(quality_filter, graph_map_filter, attr_map_filter, entry_map_filter)
  return #list > 0
end

function M:get_puzzle_attrs_by_data(puzzle_graph)
  local attrs = {}
  if not puzzle_graph or not puzzle_graph.puzzle_place_infos then
    return attrs
  end
  for _, puzzle_place_info in ipairs(puzzle_graph.puzzle_place_infos) do
    if puzzle_place_info.attr_list then
      for _, attr_cfg_id in ipairs(puzzle_place_info.attr_list) do
        local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
        local attr_id = attr_cfg.AttrId
        if not attrs[attr_id] then
          attrs[attr_id] = {FIXED = 0, RATIO = 0}
        end
        if 1 == attr_cfg.AttrType then
          attrs[attr_id].RATIO = attrs[attr_id].RATIO + attr_cfg.AttrValue
        else
          attrs[attr_id].FIXED = attrs[attr_id].FIXED + attr_cfg.AttrValue
        end
      end
    end
  end
  return attrs
end

function M:check_buddy_puzzle_map_unlock(buddy_id, show_tips)
  local condition_id = ShareRes.get_buddy_puzzle_map_unlock_cond(buddy_id)
  return Condition:check_condition(condition_id, show_tips)
end

M.TabEnum = {Graph = 1, Entry = 2}
M.FilterTypeEnum = {
  Quality = 1,
  Graph = 2,
  Entry = 3,
  Attr = 4
}

function M:init_view_filter(tab_type)
  tab_type = tab_type or self.TabEnum.Graph
  self.v_view_filter = {
    tab_type = tab_type,
    [self.FilterTypeEnum.Quality] = nil,
    [self.FilterTypeEnum.Graph] = nil,
    [self.FilterTypeEnum.Entry] = nil,
    [self.FilterTypeEnum.Attr] = nil
  }
end

function M:is_any_filter()
  if not self.v_view_filter then
    return false
  end
  local q_filter = self.v_view_filter[self.FilterTypeEnum.Quality] ~= nil
  local g_filter = nil ~= self.v_view_filter[self.FilterTypeEnum.Graph]
  local e_filter = nil ~= self.v_view_filter[self.FilterTypeEnum.Entry]
  local a_filter = nil ~= self.v_view_filter[self.FilterTypeEnum.Attr]
  return q_filter or g_filter or e_filter or a_filter
end

function M:get_view_filter_tab_type()
  if not self.v_view_filter then
    self:init_view_filter()
  end
  return self.v_view_filter.tab_type
end

function M:set_view_filter_tab_type(tab_type)
  if not self.v_view_filter then
    self:init_view_filter()
  end
  self.v_view_filter.tab_type = tab_type
  if self.v_view_filter then
    if tab_type == self.TabEnum.Graph then
      self.v_view_filter[self.FilterTypeEnum.Entry] = nil
    else
      self.v_view_filter[self.FilterTypeEnum.Graph] = nil
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE)
end

function M:reset_view_filter()
  local tab_type = self.v_view_filter and self.v_view_filter.tab_type
  self:init_view_filter(tab_type)
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE)
end

function M:get_view_filter(_type)
  if not self.v_view_filter then
    self:init_view_filter()
  end
  return self.v_view_filter[_type]
end

function M:set_view_filter(_type, key, force_remove)
  local filter_map = self.v_view_filter[_type]
  if not filter_map then
    if not force_remove then
      self.v_view_filter[_type] = {
        [key] = true
      }
    end
  else
    if force_remove then
      filter_map[key] = nil
    else
      filter_map[key] = not filter_map[key]
    end
    if not filter_map[key] then
      local is_empty = true
      for _, bool_val in pairs(filter_map) do
        if bool_val then
          is_empty = false
          break
        end
      end
      if is_empty then
        self.v_view_filter[_type] = nil
      end
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE)
end

function M:set_view_filter_ex(_type, map)
  if not self.v_view_filter then
    self:init_view_filter()
  end
  self.v_view_filter[_type] = map
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE_EX)
  msg.mm_x = _type
end

function M:get_view_puzzle_list()
  local list = {}
  if not self.v_puzzle_map or not self.v_view_filter then
    return list
  end
  local tab_type = self.v_view_filter.tab_type
  local quality_map_filter = self.v_view_filter[self.FilterTypeEnum.Quality]
  local graph_map_filter = self.v_view_filter[self.FilterTypeEnum.Graph]
  local entry_map_filter = self.v_view_filter[self.FilterTypeEnum.Entry]
  local attr_map_filter = self.v_view_filter[self.FilterTypeEnum.Attr]
  if tab_type == self.TabEnum.Graph then
    entry_map_filter = nil
  else
    graph_map_filter = nil
  end
  for _, data in pairs(self.v_puzzle_map) do
    if not quality_map_filter or quality_map_filter[data.quality] then
      local cfg = ShareRes.get_buddy_puzzle_cfg(data.id)
      local graph_pass = not graph_map_filter or graph_map_filter[cfg.GraphID]
      local attr_pass = false
      if graph_pass then
        if attr_map_filter then
          for _, attr_cfg_id in ipairs(data.attr_list) do
            local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
            local attr_id = attr_cfg.AttrId
            if attr_map_filter[attr_id] then
              attr_pass = true
              break
            end
          end
        else
          attr_pass = true
        end
      end
      local entry_id = cfg.EntryId or 0
      local entry_pass = not entry_map_filter or entry_map_filter[entry_id]
      if attr_pass and entry_pass then
        data.graph_id = cfg.GraphID
        list[#list + 1] = data
      end
    end
  end
  return list
end

function M:get_puzzle_change_when_buddy_break(buddy_id, new_break_lv)
  local cfg = ShareRes.get_buddy_puzzle_map_unlock_cfg(buddy_id)
  local old_unlock_idx, new_unlock_idx
  for i, cond_id in ipairs(cfg.Condition) do
    if 0 == cond_id then
      old_unlock_idx = i
    else
      local cond_cfg = ShareRes.get_battle_task_condition_cfg(cond_id)
      if cond_cfg.Type == 1071 then
        local unlock_lv = cond_cfg.Param[2]
        if new_break_lv > unlock_lv then
          old_unlock_idx = i
        elseif new_break_lv == unlock_lv then
          new_unlock_idx = i
        else
          break
        end
      end
    end
  end
  local old_node_num, new_node_num
  local is_first_unlock = nil ~= new_unlock_idx and nil == old_unlock_idx
  local is_new_unlock = nil ~= new_unlock_idx and nil ~= old_unlock_idx
  if is_new_unlock then
    old_node_num = self:get_graph_node_num(cfg.GraphID[old_unlock_idx])
    new_node_num = self:get_graph_node_num(cfg.GraphID[new_unlock_idx])
  end
  return is_first_unlock, is_new_unlock, old_node_num, new_node_num
end

function M:get_graph_node_num(graph_id)
  if not graph_id then
    return 0
  end
  local graph_pos_cfg = ShareRes.get_buddy_puzzle_graph_hex_pos(graph_id, 0)
  return #graph_pos_cfg
end

function M:get_puzzle_num()
  return UtilTable.hash_lenth(self.v_puzzle_map)
end

function M:is_puzzle_bag_full()
  local own_num = UtilTable.hash_lenth(self.v_puzzle_map)
  local max_num = ShareRes.get_bag_capacity_by_award_type(Config.AWARD_TYPE.PUZZLE)
  return own_num >= max_num
end

local puzzle_award_type = ShareRes.create("item.award_type", Config.AWARD_TYPE.PUZZLE)

function M:is_puzzle_item(item_id)
  return item_id >= puzzle_award_type.IdBegin and item_id <= puzzle_award_type.IdEnd
end

return M
