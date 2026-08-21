local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
end

function M:on_destroy()
  Base.on_destroy(self)
  UIMgr:try_hide_ui("ui_maze_game_settle_tips")
  UIMgr:try_hide_ui("ui_maze_game_battle_tips")
  UIMgr:clear_main_scene_after_load_ui()
end

function M:on_fight_end(msg)
  local point_id = TowerMgr:get_cur_point_id()
  if self.v_battle_point_id == point_id then
    self.v_battle_result = msg.mm_x
    if self.v_battle_result then
      local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(self.v_battle_option_id)
      if option_cfg.Param[2] then
        self.v_battle_event_id = option_cfg.Param[2]
        UIMgr:clear_main_scene_after_load_ui()
        UIMgr:set_main_scene_after_load_ui("ui_maze_game_event", self.v_activity_id, self.v_battle_point_id, self.v_battle_node_id, self.v_battle_event_id, self.v_battle_option_id, true)
      else
        self:try_comp_node(self.v_battle_node_id)
        self:clear_battle_node_param()
      end
    end
  end
end

function M:start_game(activity_id, point_id)
  self:sys_mq_bind(Const.MSG_ON_FIGHT_END, self.on_fight_end, self)
  self:init_game_data(activity_id, point_id)
  UIMgr:try_show_ui("ui_maze_game_view")
end

function M:restart_game()
  self:init_game_data(self.v_activity_id, self.v_point_id)
  MsgGame:mq_publish2(Const.ON_PONDER_MAZE_RESTART)
end

function M:init_game_data(activity_id, point_id)
  self.v_is_defeated = false
  self.v_is_victory = false
  self.v_is_game_stop = false
  self.v_activity_id = activity_id
  self.v_point_id = point_id
  local point_cfg = ShareRes.get_ponder_maze_point_cfg(self.v_point_id)
  self.v_map_id = point_cfg.MapID
  local map_cfg = ShareRes.get_ponder_maze_map_cfg(self.v_map_id)
  self.v_library_id = map_cfg.NodeLibraryID
  local node_cfgs = ShareRes.get_ponder_maze_node_library_cfg(self.v_library_id)
  self.v_wait_comp_event_id = {}
  self.v_node_state_map = {}
  for node_id, node_cfg in pairs(node_cfgs) do
    if not self.v_node_state_map[node_id] then
      local is_type1 = 1 == node_cfg.NodeType
      self.v_node_state_map[node_id] = {
        node_id = node_id,
        is_comp = is_type1,
        is_active = is_type1
      }
    end
    local pre_node
    for key, pre_node_id in pairs(node_cfg.PreNode) do
      pre_node = pre_node or {}
      pre_node[pre_node_id] = pre_node_id
    end
    self.v_node_state_map[node_id].pre_node = pre_node
  end
  self.v_thought_count_map = {}
  for index, thought_id in pairs(map_cfg.Thought) do
    local cur_count = self.v_thought_count_map[thought_id] or 0
    local add_count = map_cfg.ThoughtNum[index] or 0
    self.v_thought_count_map[thought_id] = cur_count + add_count
  end
  self.v_clue_count_map = {}
  self.v_target_clue_count_map = {}
  for index, clue_id in pairs(map_cfg.TargetClue) do
    local cur_count = self.v_target_clue_count_map[clue_id] or 0
    local add_count = map_cfg.ClueCount[index] or 0
    self.v_target_clue_count_map[clue_id] = cur_count + add_count
  end
  self:check_all_node_active()
end

function M:check_node_active(node_id)
  local node_data = self.v_node_state_map[node_id]
  if not node_data or node_data.is_active then
    return
  end
  local is_active = false
  local pre_node_map = node_data.pre_node
  if pre_node_map then
    for pre_node_id in pairs(pre_node_map) do
      local pre_node_data = self.v_node_state_map[pre_node_id]
      if pre_node_data and pre_node_data.is_comp then
        is_active = true
        break
      end
    end
  else
    is_active = true
  end
  node_data.is_active = is_active
end

function M:check_all_node_active()
  for node_id in pairs(self.v_node_state_map) do
    self:check_node_active(node_id)
  end
end

function M:complete_node(node_id)
  local node_data = self.v_node_state_map[node_id]
  if not node_data or node_data.is_comp then
    return
  end
  node_data.is_comp = true
  self:check_all_node_active()
  MsgGame:mq_publish2(Const.ON_PONDER_MAZE_NODE_UPDATE)
  local node_cfg = ShareRes.get_ponder_maze_node_cfg(node_id)
  if node_cfg.RelevantClue then
    self:add_clue_count(node_cfg.RelevantClue, node_cfg.SucClueCount)
  end
end

function M:get_node_active_state(node_id)
  local node_data = self.v_node_state_map[node_id]
  return node_data and node_data.is_active or false
end

function M:get_node_comp_state(node_id)
  local node_data = self.v_node_state_map[node_id]
  return node_data and node_data.is_comp or false
end

function M:get_thought_count(thought_id)
  return self.v_thought_count_map[thought_id] or 0
end

function M:add_thought_count(thought_id, add_count)
  if self.v_is_game_stop then
    return
  end
  local cur_count = self.v_thought_count_map[thought_id] or 0
  self.v_thought_count_map[thought_id] = cur_count + add_count
  local thought_empty = true
  for _, count in pairs(self.v_thought_count_map) do
    if count > 0 then
      thought_empty = false
    end
  end
  if thought_empty then
    self:game_defeated()
  end
  MsgGame:mq_publish2(Const.ON_PONDER_MAZE_ITEM_UPDATE)
end

function M:get_clue_count(clue_id)
  return self.v_clue_count_map[clue_id] or 0
end

function M:add_clue_count(clue_id, add_count)
  if self.v_is_game_stop then
    return
  end
  local cur_count = self.v_clue_count_map[clue_id] or 0
  self.v_clue_count_map[clue_id] = cur_count + add_count
  if self.v_target_clue_count_map[clue_id] then
    local enough = true
    for target_clue, count in pairs(self.v_target_clue_count_map) do
      if count > self:get_clue_count(target_clue) then
        enough = false
      end
    end
    if enough then
      self:game_victory()
    end
  end
  MsgGame:mq_publish2(Const.ON_PONDER_MAZE_ITEM_UPDATE)
end

function M:add_wait_comp_event(event_id)
  self.v_wait_comp_event_id[event_id] = true
end

function M:try_interactable_node(node_id)
  if self.v_is_game_stop then
    return
  end
  local node_data = self.v_node_state_map[node_id]
  if not node_data or node_data.is_comp or not node_data.is_active then
    return
  end
  local node_cfg = ShareRes.get_ponder_maze_node_cfg(node_id)
  local thought_id = node_cfg.ThoughtId
  if self:get_thought_count(thought_id) <= 0 then
    return
  end
  if not node_cfg.Event then
    self:try_comp_node(node_id)
    return
  end
  UIMgr:try_show_ui("ui_maze_game_event", nil, self.v_activity_id, self.v_point_id, node_id, node_cfg.Event)
end

function M:try_comp_node(node_id)
  if self.v_is_game_stop then
    return
  end
  local node_cfg = ShareRes.get_ponder_maze_node_cfg(node_id)
  local thought_id = node_cfg.ThoughtId
  if self:get_thought_count(thought_id) <= 0 then
    return false
  end
  self:complete_node(node_id)
  self:add_thought_count(thought_id, -1)
  return true
end

function M:enter_option_battle(node_id, event_id, option_id)
  local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(option_id)
  local battle_point_id = option_cfg.Param[1]
  self.v_battle_node_id = node_id
  self.v_battle_option_id = option_id
  self.v_battle_point_id = battle_point_id
  self.v_battle_event_id = event_id
  UIMgr:try_show_ui("ui_maze_game_battle_tips", nil, node_id, option_id)
end

function M:is_game_stop()
  return self.v_is_game_stop
end

function M:get_battle_pass_id(point_id, node_id)
  return point_id * 1000 + node_id
end

function M:get_game_param()
  return self.v_activity_id, self.v_point_id, self.v_map_id
end

function M:get_battke_param()
  return self.v_battle_point_id, self.v_battle_node_id, self.v_battle_event_id, self.v_battle_option_id
end

function M:is_battle_pass()
  return self.v_battle_result
end

function M:clear_battle_node_param()
  self.v_battle_node_id = nil
  self.v_battle_option_id = nil
  self.v_battle_point_id = nil
  self.v_battle_result = nil
end

function M:game_victory()
  if self.v_is_victory or self.v_is_defeated then
    return
  end
  self.v_is_victory = true
  self.v_is_game_stop = true
  local ponder_id = self:get_ponder_result()
  NoviceMgr:request_activity_ponder_report_pass_point(self.v_activity_id, self.v_point_id, true, function()
    NoviceMgr:set_is_need_show_maze_game_settle_tips(true)
    NoviceMgr:set_maze_game_settle_tips_ponder_id(ponder_id)
  end)
  NoviceMgr:set_is_need_show_maze_game_settle_tips(true)
  NoviceMgr:set_maze_game_settle_tips_ponder_id(ponder_id)
end

function M:game_defeated()
  if self.v_is_victory or self.v_is_defeated then
    return
  end
  self.v_is_defeated = true
  self.v_is_game_stop = true
  NoviceMgr:request_activity_ponder_report_pass_point(self.v_activity_id, self.v_point_id, false, function()
    self:open_settle_tips()
  end)
  self:open_settle_tips()
end

function M:open_settle_tips(close_callback)
  UIMgr:try_destory_ui("ui_maze_game_settle_tips")
  UIMgr:get_ui("ui_maze_game_settle_tips"):ui_show(nil, close_callback)
end

function M:get_ponder_result()
  local map_cfg = ShareRes.get_ponder_maze_map_cfg(self.v_map_id)
  return (not self.v_is_victory or not map_cfg.TargetPonder) and self.v_is_defeated and map_cfg.DefPonder
end

function M:is_game_victory()
  return self.v_is_victory
end

function M:start_battle()
  local battle_param = self:get_battle_pass_id(self.v_battle_point_id, self.v_battle_node_id)
  local activity_id = self.v_activity_id
  UIMgr:get_ui("team"):ui_show(nil, self.v_battle_point_id, Config.CommonDefine.CHALLENGE_TYPE.ACTIVITY_PONDER, nil, nil, nil, {activity_id, battle_param})
  UIMgr:set_main_scene_after_load_ui("ui_maze_game_view")
end

return M
