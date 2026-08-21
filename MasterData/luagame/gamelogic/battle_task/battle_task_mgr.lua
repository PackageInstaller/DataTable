local Base = require("gamelogic.base_system")
local Task = require("gamelogic.battle_task.battle_task")
local BATTLE_TASK_CFG = require("uimodule.fight_task.battle_task_config")
local CommonDefine = require("cs_share.common_define")
local TASK_STATE = BATTLE_TASK_CFG.TASK_STATE
local BATTLE_TASK_TYPE = BATTLE_TASK_CFG.TASK_TYPE
local ROOM_LOCK_STATE = Config.ROOM_LOCK_STATE
local _insert = table.insert
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.is_enter_by_branch_node = false
  self.task_list = {}
  self.v_fight_time = 0
  self.v_record_progress_param = {}
  self:_set_trace_task_id(0)
  self.v_reach_condition_list = {}
  self.v_node_task_map = {}
end

function M:on_reconnect()
  for _, task in pairs(self.task_list) do
    task:release_task()
  end
  self.task_list = {}
  self.v_node_task_map = {}
end

function M:sync_battle_task_list(data)
  if not data.task_list then
    return
  end
  self.task_list = {}
  for k, v in pairs(data.task_list) do
    self.task_list[v.id] = Task:new(v)
  end
  local old_track_task_id = self.v_track_task_id
  self:_set_trace_task_id(data.mark_task)
  if old_track_task_id ~= self.v_track_task_id then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_ID)
    msg.mm_x = old_track_task_id
    self.v_node_task_map[self.v_track_task_id] = true
  end
  MsgGame:mq_publish2(Const.MSG_ON_BATTLE_TASK_UPDATE)
end

function M:sync_battle_task_info(data)
  local task_data = data.task
  if not task_data then
    return
  end
  self:check_conditions_is_reach(task_data)
  local task = self.task_list[task_data.id]
  if task then
    task:update_task_info(task_data)
  else
    self.task_list[task_data.id] = Task:new(task_data)
    self.v_node_task_map[task_data.id] = true
    local msg = MsgGame:mq_publish2(Const.MSG_ON_BATTLE_TASK_RECEIVE_OR_COMPLETE)
    msg.mm_x = task_data.id
    msg.mm_y = TASK_STATE.RECEIVE
  end
  if task_data.id == self.v_track_task_id then
    MsgGame:mq_publish2(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_PRO)
  elseif task_data.state == TASK_STATE.RECEIVE or task_data.state == TASK_STATE.COMPLETE then
    local task_item = self:get_task(task_data.id) or {}
    local task_cfg = task_item.v_task_cfg
    if task_cfg and task_cfg.Type == BATTLE_TASK_TYPE.MAIN then
      self:change_tack_task_id(task_data.id)
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_BATTLE_TASK_UPDATE)
  if task_data.state == TASK_STATE.COMPLETE or task_data.state == TASK_STATE.GET_REWARD then
    BehaviorMgr:call_scene_logic_event_fun("on_task_finish", task_data.id)
  end
end

function M:check_conditions_is_reach(task_data)
  local progress = task_data.progress
  if not progress then
    return
  end
  local is_all_progress_zero = true
  for _, info in ipairs(progress) do
    if 0 ~= info.progress then
      is_all_progress_zero = false
      break
    end
  end
  if is_all_progress_zero then
    self.v_reach_condition_list = {}
    return
  end
  for _, info in ipairs(progress) do
    if 0 ~= info.progress then
      local condition_info = ShareRes.create("battle.battle_condition", info.id)
      if info.progress >= condition_info.Value and not self.v_reach_condition_list[info.id] and BehaviorMgr then
        BehaviorMgr:call_scene_logic_event_fun("on_task_condition_reach", info.id)
        self.v_reach_condition_list[info.id] = 1
      end
    end
  end
end

function M:sync_battle_task_failed(task_id)
  local task = self.task_list[task_id]
  if not task then
    Log.Error("get task failure!, task_id=", task_id)
    return
  end
  task:set_task_failure()
  task = nil
  self.task_list[task_id] = nil
end

function M:update_track_task_id(data)
  local old_track_task_id = self.v_track_task_id
  self:_set_trace_task_id(data.task_id)
  if old_track_task_id ~= self.v_track_task_id then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_ID)
    msg.mm_x = old_track_task_id
    self.v_node_task_map[self.v_track_task_id] = true
  end
end

function M:request_accept_npc_task(npc_id, group_id, task_id)
  local send = {
    npc_id = npc_id,
    group_id = group_id,
    task_id = task_id
  }
  Network:call("c2gs_accept_npc_task", send)
end

function M:change_tack_task_id(task_id)
  Network:call("c2gs_mark_task", {task_id = task_id}, function(ok, resp)
    if ok then
    end
  end)
end

function M:update(delta_time)
  if not SceneMgr or SceneMgr:get_game_pause() then
    return
  end
  self.v_fight_time = self.v_fight_time + delta_time
  for _, v in pairs(self.task_list) do
    v:update(delta_time)
  end
end

function M:get_show_magic()
  local tb = {}
  for _, v in pairs(self.task_list) do
    if v:get_is_processing() and v:get_cnt_magic() > 0 then
      table.insert(tb, v:get_cnt_magic())
    end
  end
  return tb
end

function M:clear_all_tasks()
  for _, task in pairs(self.task_list) do
    task:release_task()
  end
  self.task_list = {}
  self.v_record_progress_param = {}
  self:_set_trace_task_id(0)
  self.v_reach_condition_list = {}
  self.v_node_task_map = {}
end

function M:set_fight_time(time)
  self.v_fight_time = time
end

function M:get_fight_time()
  return self.v_fight_time
end

function M:_set_trace_task_id(task_id)
  self.v_track_task_id = task_id
end

function M:get_task(task_id)
  if task_id then
    return self.task_list[task_id]
  end
  return self.task_list
end

function M:get_track_task_id()
  return self.v_track_task_id
end

function M:get_track_task_item()
  local task_id = self.v_track_task_id
  if task_id and task_id > 0 then
    return self:get_task(task_id)
  end
end

function M:is_track_main_task()
  if not self.v_track_task_id or 0 == self.v_track_task_id then
    return
  end
  local task_item = self:get_task(self.v_track_task_id)
  if not task_item then
    return
  end
  local task_cfg = task_item.v_task_cfg
  if task_cfg and task_cfg.Type == BATTLE_TASK_TYPE.MAIN then
    return true
  end
end

function M:check_task_relation_room(room_index)
  local task_list = self.task_list
  local task_id_list = {}
  for _, task in pairs(task_list) do
    local task_cfg = task:get_task_cfg()
    local task_state = task:get_state()
    if task_cfg.RoomContace then
      for _, desc in pairs(task_cfg.RoomContace) do
        local room_list = Util.split_str(desc, "&")
        local room_id = tonumber(room_list[1])
        if room_id == room_index and task_state < TASK_STATE.COMPLETE then
          task_id_list[task:get_task_id()] = true
          break
        end
      end
    end
  end
  return task_id_list
end

function M:get_task_relation_room_path(target_room_id)
  local tower = TowerMgr:get_tower()
  self.v_is_navogator_end = false
  if not tower then
    return
  end
  local roomList = tower:get_cur_floor_room_list()
  local relation_info = {}
  local record_list = {}
  local target_room_num, tp_room_id
  local cur_room_num = tower:get_room_num()
  for index, data in pairs(roomList) do
    local connect_info = data.RoomConnectDic
    local room_num = data.RoomNum
    relation_info[room_num] = {}
    for tp_id, info in pairs(connect_info) do
      local tp_condition = info.UnlockCondition
      local is_unlock = self:check_condition(tp_condition)
      local tp_room_num = info.TargetRoomNum
      if (is_unlock or not info.IsLocked) and not tower:get_tp_is_locked(room_num, tp_id) then
        relation_info[room_num][tp_id] = {
          target_num = info.TargetRoomNum,
          tar_dir = info.TargetDir
        }
      end
    end
    if data.EndDir and 0 ~= data.EndDir then
      relation_info[room_num][data.EndDir] = {is_tp_next = true}
      tp_room_id = room_num
    end
    if data.LogicNum == target_room_id then
      target_room_num = room_num
    end
  end
  local relation_room_data = relation_info[target_room_num]
  local is_next_floor = false
  if not relation_room_data then
    is_next_floor = true
  end
  local target_room_data = {
    target_room_num = target_room_num,
    is_next_floor = is_next_floor,
    start_room_num = cur_room_num,
    tp_room_id = tp_room_id
  }
  if cur_room_num == target_room_num then
    return nil, true
  end
  local cur_relation_info = relation_info[cur_room_num]
  Util.assert(cur_relation_info, "缺少当前房间联通数据")
  local path_list = {}
  local cache_path = {}
  self:get_path(cur_room_num, relation_info, target_room_data, path_list, cache_path)
  local select_path
  if #path_list > 0 then
    for i = 1, #path_list do
      local data = path_list[i]
      if not select_path or #select_path > #data then
        select_path = data
      end
    end
  end
  return select_path
end

function M:get_path(cur_room_num, relation_info, target_room_data, path_list, cache_path, cache_room_id)
  cache_path = cache_path or {}
  cache_room_id = cache_room_id or {}
  if not cur_room_num then
    return
  end
  local cur_relation_info = relation_info[cur_room_num]
  if not cur_relation_info then
    return
  end
  local target_room_num = target_room_data.target_room_num
  local is_next_floor = target_room_data.is_next_floor
  local start_room_num = target_room_data.start_room_num
  local tp_room_id = target_room_data.tp_room_id
  local is_end = false
  if tp_room_id and tp_room_id == cur_room_num then
    is_end = true
  end
  local next_room, select_tp_id
  for tp_idx, data in pairs(cur_relation_info) do
    if not data.is_tp_next then
      local next_tp_info = relation_info[data.target_num][data.tar_dir]
      if not data.is_through and not next_tp_info.is_through then
        next_room = data.target_num
        select_tp_id = tp_idx
        data.is_through = true
        break
      end
    end
  end
  if next_room and select_tp_id and not is_end then
    _insert(cache_path, {room_num = cur_room_num, tp_idx = select_tp_id})
  end
  local is_ok = false
  if target_room_num and 0 ~= target_room_num then
    if target_room_num == next_room then
      is_ok = true
    end
  elseif is_next_floor then
    local room_num = next_room and next_room or cur_room_num
    if is_end then
      room_num = cur_room_num
    end
    local next_room_data = relation_info[room_num]
    for index, data in pairs(next_room_data) do
      if data.is_tp_next then
        is_ok = true
        _insert(cache_path, {room_num = room_num, tp_idx = index})
        break
      end
    end
  end
  
  local function cb()
    self:get_next_room_id(cache_path, relation_info, start_room_num, 2)
    cur_room_num = self.v_next_room_id
    if cur_room_num and not self.v_is_navogator_end then
      self:get_path(cur_room_num, relation_info, target_room_data, path_list, cache_path)
    end
    self.v_next_room_id = nil
  end
  
  if not is_ok then
    if not next_room then
      cb()
    elseif next_room then
      cur_room_num = next_room
      self:get_path(cur_room_num, relation_info, target_room_data, path_list, cache_path)
    end
  else
    local new_path = UtilTable.copy_table(cache_path)
    _insert(path_list, new_path)
    cb()
  end
end

function M:get_next_room_id(cache_path, relation_info, start_room_num, init_idx)
  local room_id, select_index
  if #cache_path <= 0 then
    self.v_next_room_id = nil
    local room_info = relation_info[start_room_num]
    for tp_idx, data in pairs(room_info) do
      if not data.is_tp_next and not data.is_through then
        self.v_next_room_id = start_room_num
        break
      end
    end
    if not self.v_next_room_id then
      self.v_is_navogator_end = true
    end
    return
  end
  for i = init_idx, #cache_path do
    local cache_data = cache_path[i]
    local room_info = relation_info[cache_data.room_num]
    local break_for = false
    for tp_idx, data in pairs(room_info) do
      if not data.is_tp_next then
        local next_tp_info = relation_info[data.target_num][data.tar_dir]
        if not next_tp_info.is_through and not data.is_through then
          room_id = cache_data.room_num
          select_index = i
          break_for = true
          break
        end
      end
    end
    if break_for then
      break
    end
  end
  
  local function clear_cb(index)
    select_index = index or select_index
    for i = #cache_path, 1, -1 do
      if i >= select_index then
        if i ~= select_index then
          local cache_data = cache_path[i]
          local cache_room_num = cache_data.room_num
          local cache_tp_idx = cache_data.tp_idx
          local room_info = relation_info[cache_room_num]
          if cache_room_num ~= start_room_num then
            for tp_idx, data in pairs(room_info) do
              data.is_through = false
            end
          elseif 1 ~= i then
            room_info[cache_tp_idx].is_through = false
          end
        end
        table.remove(cache_path, i)
      else
        break
      end
    end
  end
  
  if select_index and room_id then
    clear_cb()
  end
  if not room_id and init_idx > 1 then
    clear_cb(1)
    self:get_next_room_id(cache_path, relation_info, start_room_num, 1)
  else
    self.v_next_room_id = room_id
  end
end

function M:check_condition(condition_list)
  for key, condition_id in pairs(condition_list) do
    if not Condition:check_condition(condition_id) then
      return false
    end
  end
  return true
end

function M:check_track_task()
  local task_list = self:get_task()
  local task_len = UtilTable.hash_lenth(task_list)
  if 0 == task_len then
    return
  end
  local track_task_id = self:get_track_task_id()
  if not track_task_id or 0 == track_task_id then
    return
  end
  local task_item = self:get_task(track_task_id)
  if not task_item or not task_item.v_task_cfg then
    return
  end
  return true
end

function M:check_need_send_save_req(task_cfg)
  if not task_cfg then
    return
  end
  if TowerMgr then
    local fight_type = TowerMgr:get_fight_type()
    if fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
      local group_id = task_cfg.Group
      local node_cfg = ShareRes.get_node_by_param_id(group_id)
      if node_cfg and node_cfg.NodeType == CommonDefine.CHAPTER_NODE_TYPE.BRANCH_LINE then
        local cfg = ShareRes.get_battle_task_group_list(group_id)
        local is_complete = nil ~= cfg and nil ~= next(cfg)
        if is_complete then
          for key, value in pairs(cfg) do
            local task = self:get_task(key)
            if task then
              if task:get_state() < TASK_STATE.COMPLETE then
                is_complete = false
                break
              end
            else
              is_complete = false
              break
            end
          end
        end
        if is_complete then
          TowerMgr:req_chapter_node_save_by_branch_task(node_cfg.Id)
        end
      end
    end
  end
end

function M:get_record_progress_param(id)
  return self.v_record_progress_param[id]
end

function M:add_record_progress_param(id, value)
  self.v_record_progress_param[id] = (self.v_record_progress_param[id] or 0) + value
end

function M:get_node_task_map()
  return self.v_node_task_map
end

function M:clear_node_task_map()
  self.v_node_task_map = {}
  if Util.is_more_than_zero(self.v_track_task_id) then
    self.v_node_task_map[self.v_track_task_id] = true
  end
end

function M:request_add_task_progress(id, value, callback)
  if SceneMgr:check_main_scene() then
    return
  end
  
  local function cb()
    if SceneMgr:check_main_scene() then
      return
    end
    self:add_record_progress_param(id, value)
    MsgGame:mq_publish2(Const.MSG_ON_TOWER_DATA_UPDATE)
  end
  
  local body = {id = id, value = value}
  Network:call("c2gs_client_behavior_add_condtion_value", body, function(ok, resp)
    if ok then
      cb()
      if callback then
        callback(resp)
      end
    end
  end)
end

return M
