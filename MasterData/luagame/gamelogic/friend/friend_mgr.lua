local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local CommonDefind = require("cs_share.common_define")
local FRIEND_STATE = CommonDefind.FRIEND_STATE
local APPLY_LIST_REDPOINT = 8
local FRIEND_LIST_REDPOINT = 7
local FRIEND_SYS_ID = 12
local FRIEND_INDEX = 1
local APPLY_INDEX = 2
local FRIEND_REFRESH_CD = ShareRes.get_system_comm_value("RefreshFriendListCD")
local FRIEND_MAX_NUM = ShareRes.get_system_comm_value("FriendNumLimit")
local LocalStorage = require("utils.localstorage")

function M:init_sys()
  Base.init_sys(self)
  self:reset_data()
end

function M:on_reconnect()
  self:reset_data()
end

function M:reset_data()
  self.v_friend_list = {}
  self.v_apply_list = {}
  self.v_role_info = {}
  self.v_search_role_list = {}
  self.v_cache_applied_tag = {}
  self.v_friend_black_list = {}
  self.v_can_receive_friendships = {}
  self.v_had_send_friendships = {}
  self.v_had_send_count = 0
  self:sys_mq_bind(Const.MSG_SYS_OPEN, self.init_data, self)
end

function M:init_data()
  self:request_get_friend_list()
  self:request_get_apply_list(nil, true)
end

function M:on_release()
  if self.v_time_index then
    Timer:remove_timer(self.v_time_index)
    self.v_time_index = nil
  end
end

function M:get_friend_list()
  return self.v_friend_list
end

function M:get_friend_info_by_id(uuid)
  return self.v_friend_list[uuid]
end

function M:get_apply_list()
  return self.v_apply_list
end

function M:get_friend_black_list()
  return self.v_friend_black_list
end

function M:is_in_friend_black(uuid)
  if self.v_friend_black_list[uuid] then
    return true
  end
  for index, info in ipairs(self.v_friend_black_list) do
    if info.uuid == uuid then
      return true
    end
  end
  return false
end

function M:is_in_friend(uuid)
  if self.v_friend_list[uuid] then
    return true
  end
  return false
end

function M:get_search_role_list()
  return self.v_search_role_list
end

function M:clear_search_role_list()
  self.v_search_role_list = {}
end

function M:get_friend_num()
  local num = UtilTable.hash_lenth(self.v_friend_list)
  return num
end

function M:is_show_friend_red()
  return #self.v_apply_list > 0
end

function M:update_red()
  local friend_list = self:get_friend_list()
  local red_show = false
  if nil ~= friend_list then
    for key, data in pairs(friend_list) do
      if FriendMgr:can_receive_friendship(data.uuid) then
        red_show = true
        break
      end
    end
  end
  RedPointMgr:enable_redpoint(FRIEND_LIST_REDPOINT, red_show)
  self:request_get_apply_list()
end

function M:check_friend_sys_open()
  if not SysOpenMgr:get_sys_is_open(FRIEND_SYS_ID) then
    return
  end
  return true
end

function M:check_request_time(last_time)
  local time = Date.server_time()
  if not last_time then
    return true
  end
  return time - last_time >= FRIEND_REFRESH_CD
end

function M:check_applied_by_uuid(uuid)
  return self.v_cache_applied_tag[uuid]
end

function M:refresh_apply_list()
  local agree_list = {}
  for _, data in pairs(self.v_apply_list) do
    if data.friend_status == FRIEND_STATE.APPLIED then
      agree_list[data.uuid] = true
    end
  end
  for uuid, _ in pairs(agree_list) do
    self:accept_friend_apply(uuid, nil, true)
  end
end

function M:get_friend_state(uuid)
  local state = FRIEND_STATE.APPLY
  if self.v_friend_list[uuid] then
    state = FRIEND_STATE.FRIEND
    return state
  end
  for key, info in pairs(self.v_apply_list) do
    if info.uuid == uuid then
      state = FRIEND_STATE.APPLIED
      return state
    end
  end
  if self.v_role_info[uuid] then
    state = self.v_role_info[uuid].friend_status
    return state
  end
  if self:check_applied_by_uuid(uuid) then
    return FRIEND_STATE.APPLIED
  end
  if self.v_friends_recommendlist then
    for k, v in pairs(self.v_friends_recommendlist) do
      if v.uuid == uuid then
        return v.friend_status
      end
    end
  end
  return state
end

function M:set_show_player_info(player_info)
  self.v_show_player_info = player_info
end

function M:get_show_player_info()
  return self.v_show_player_info
end

function M:request_get_friend_list(callback, no_check_time)
  if not self:check_friend_sys_open() then
    return
  end
  if not self:check_request_time(self.v_request_friend_time) and not no_check_time then
    return
  end
  self.v_request_friend_time = Date.server_time()
  Network:call("c2gs_get_friendlist", {}, function(ok, resp)
    if ok then
      self.v_friend_list = {}
      self.v_friend_black_list = {}
      for _, friend_info in pairs(resp.friend_list) do
        self.v_cache_applied_tag[friend_info.uuid] = nil
        self.v_friend_list[friend_info.uuid] = friend_info
      end
      self.v_friend_black_list = resp.blacklist
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_LIST)
      if callback then
        callback()
      end
    end
  end)
end

function M:request_get_apply_list(callback, is_refresh)
  if not self:check_friend_sys_open() then
    return
  end
  if not self:check_request_time(self.v_request_apply_time) then
    return
  end
  self.v_request_apply_time = Date.server_time()
  Network:call("c2gs_get_applylist", {}, function(ok, resp)
    if ok then
      self:set_apply_list_red_point(false, self.v_apply_list, resp.apply_list)
      self.v_apply_list = resp.apply_list
      if is_refresh then
        self:refresh_apply_list()
      end
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST)
      RedPointMgr:enable_redpoint(APPLY_LIST_REDPOINT, self:get_apply_list_red_point())
      if callback then
        callback(APPLY_INDEX)
      end
    end
  end)
end

function M:set_apply_list_red_point(has_read, old_apply_list, new_apply_list)
  if has_read then
    old_apply_list = self.v_apply_list
    new_apply_list = self.v_apply_list
  end
  local storage_key = "friend_apply_list_red"
  if nil == new_apply_list then
    LocalStorage:save_int(storage_key, 0, true)
    return
  end
  local cur_state = LocalStorage:load_int(storage_key, 0, true)
  if 0 == cur_state then
    if nil ~= new_apply_list and #new_apply_list > 0 then
      LocalStorage:save_int(storage_key, 1, true)
      return
    end
  elseif 1 == cur_state then
    if nil == new_apply_list then
      LocalStorage:save_int(storage_key, 0, true)
      return
    end
    if #new_apply_list <= 0 then
      LocalStorage:save_int(storage_key, 0, true)
      return
    end
    if has_read then
      LocalStorage:save_int(storage_key, 2, true)
      return
    end
  elseif 2 == cur_state then
    if nil == new_apply_list then
      LocalStorage:save_int(storage_key, 0, true)
      return
    end
    if #new_apply_list <= 0 then
      LocalStorage:save_int(storage_key, 0, true)
      return
    end
    local search_table = {}
    if nil ~= old_apply_list then
      for _, data in pairs(old_apply_list) do
        search_table[data.uuid] = true
      end
    end
    for _, data in pairs(new_apply_list) do
      if not search_table[data.uuid] then
        LocalStorage:save_int(storage_key, 1, true)
        return
      end
    end
  end
end

function M:get_apply_list_red_point()
  local storage_key = "friend_apply_list_red"
  local cur_state = LocalStorage:load_int(storage_key, 0, true)
  return 1 == cur_state
end

function M:update_red_state(buddyid, red_id)
  local had_click = 1 == LocalStorage:load_int(storage_key, 0, true)
  RedPointMgr:enable_redpoint(red_id, not had_click)
end

function M:get_red_state(buddyid, red_id)
  local storage_key = string.format("character_red_%s_%s", red_id, buddyid)
  local had_click = 1 == LocalStorage:load_int(storage_key, 0, true)
  return not had_click
end

function M:request_get_recommendlist()
  Network:call("c2gs_flush_recommendlist", {}, function(ok, resp)
    MsgGame:mq_publish2(Const.MSG_ON_REQUEST_RCMD_LIST)
  end)
end

function M:on_get_recommendlist(data)
  self.v_friends_recommendlist = data.recommend_list
  MsgGame:mq_publish2(Const.MSG_ON_GET_NEW_RCMD_LIST)
end

function M:get_friends_recommendlist()
  return self.v_friends_recommendlist or {}
end

function M:request_get_friend_info(uuid, callback)
  Network:call("c2gs_get_friendinfo", {target_uuid = uuid}, function(ok, resp)
    if ok then
      local friend_info = resp.friend_info
      if callback then
        callback(friend_info)
      end
      self.v_friend_list[friend_info.uuid] = friend_info
    end
  end)
end

function M:set_friend_note(uuid, note, callback)
  Network:call("c2gs_set_friend_note", {target_uuid = uuid, note = note}, function(ok, resp)
    if ok then
      local friend_info = self.v_friend_list[uuid]
      friend_info.note = note
      if callback then
        callback()
      end
      local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_NOTE)
      msg.mm_x = uuid
      msg.mm_y = note
    end
  end)
end

function M:request_get_role_snapinfo(uuid, callback)
  Network:call("c2gs_get_role_snapinfo", {target_uuid = uuid}, function(ok, resp)
    if ok then
      local role_info = resp.role_info
      role_info.time = Date.server_time()
      self.v_role_info[uuid] = role_info
      if callback then
        callback(role_info)
      end
    end
  end)
end

function M:request_search_role(role_uuid, role_name, callback)
  Network:call("c2gs_search_role", {target_uuid = role_uuid, target_name = role_name}, function(ok, resp)
    if ok then
      self.v_search_role_list = resp.role_list
      for key, data in pairs(self.v_search_role_list) do
        self.v_role_info[data.uuid] = data
      end
      if callback then
        callback()
      end
    end
  end)
end

function M:apply_add_friend(uuid, callback, fail_callback, in_data)
  Network:call("c2gs_apply_newfriend", {target_uuid = uuid}, function(ok, resp)
    if ok then
      for key, data in pairs(self.v_search_role_list) do
        if data.uuid == uuid then
          data.friend_status = FRIEND_STATE.APPLIED
          self.v_role_info[data.uuid] = data
        end
      end
      if in_data and next(in_data) then
        self.v_role_info[in_data.uuid] = in_data
      end
      self.v_cache_applied_tag[uuid] = true
      if self.v_role_info[uuid] then
        self.v_role_info[uuid].friend_status = FRIEND_STATE.APPLIED
      end
      local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_STATE)
      msg.mm_x = uuid
      if callback then
        callback(uuid, FRIEND_STATE.APPLIED)
      end
    else
      self.v_cache_applied_tag[uuid] = true
      if fail_callback then
        fail_callback()
      end
    end
  end)
end

function M:accept_friend_apply(uuid, callback, no_tip)
  Network:call("c2gs_accept_newfriend", {target_uuid = uuid}, function(ok, resp)
    if ok then
      self:remove_data_by_uuid(self.v_apply_list, uuid)
      self:request_get_friend_list(nil, true)
      if not no_tip then
        Util.show_message_tip(2079)
      end
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST)
      RedPointMgr:enable_redpoint(APPLY_LIST_REDPOINT, #self.v_apply_list > 0)
    end
  end)
end

function M:remove_data_by_uuid(list, uuid)
  for index = #list, 1, -1 do
    local data = list[index]
    if data.uuid == uuid then
      table.remove(list, index)
      break
    end
  end
end

function M:refuse_friend_apply(uuid)
  Network:call("c2gs_refuse_newfriend", {target_uuid = uuid}, function(ok, resp)
    if ok then
      self:remove_data_by_uuid(self.v_apply_list, uuid)
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST)
      RedPointMgr:enable_redpoint(APPLY_LIST_REDPOINT, #self.v_apply_list > 0)
    end
  end)
end

function M:refuse_all_friend_apply()
  Network:call("c2gs_refuse_all_newfriend", {}, function(ok, resp)
    if ok then
      self.v_apply_list = {}
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST)
      RedPointMgr:enable_redpoint(APPLY_LIST_REDPOINT, #self.v_apply_list > 0)
    end
  end)
end

function M:get_all_friend_apply()
  if #self.v_apply_list > 0 then
    Network:call("c2gs_accept_all_newfriend", {}, function(ok, resp)
      if ok then
        self.v_apply_list = {}
        self:request_get_friend_list(nil, true)
        MsgGame:mq_publish2(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST)
        RedPointMgr:enable_redpoint(APPLY_LIST_REDPOINT, #self.v_apply_list > 0)
      end
    end)
  end
end

function M:delete_friend(uuid)
  Network:call("c2gs_delete_friend", {target_uuid = uuid}, function(ok, resp)
    if ok then
      Util.show_message_tip(2080)
      self.v_friend_list[uuid] = nil
      self:remove_data_by_uuid(self.v_apply_list, uuid)
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_LIST)
    end
  end)
end

function M:add_friend_black_list(uuid, player_info, callback)
  Network:call("c2gs_blacklist_role", {target_uuid = uuid}, function(ok, resp)
    if ok then
      self.v_friend_list[uuid] = nil
      table.insert(self.v_friend_black_list, 1, player_info)
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_WORLD_CHAT_CHANNEL_UPDATE)
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_LIST)
      MsgGame:mq_publish2(Const.MSG_ON_CHANGE_APPLY_FRIEND_LIST)
    end
  end)
end

function M:remove_friend_black_list(uuid, callback)
  Network:call("c2gs_blacklist_remove_role", {target_uuid = uuid}, function(ok, resp)
    if ok then
      UtilTable.list_delete_by_func(self.v_friend_black_list, function(info)
        return info.uuid == uuid
      end)
      if callback then
        callback()
      end
    end
  end)
end

function M:c2gs_get_role_buddy_info(uuid, buddy_id, callback)
  Network:call("c2gs_get_role_buddy_info", {target_uuid = uuid, buddy_id = buddy_id}, function(ok, resp)
    if ok and callback then
      resp.buddy_info.uuid = uuid
      callback(resp.buddy_info)
    end
  end)
end

function M:receive_friendship(uuid)
  Network:call("c2gs_get_present_reward", {target_uuid = uuid}, function(ok, resp)
    if not ok then
    end
    local can_send_friendship_after = self:can_send_friendship(uuid)
    if can_send_friendship_after then
      self:send_friendship(uuid, true)
    end
  end)
end

function M:send_friendship(uuid, show_tips)
  Network:call("c2gs_present_friend_reward", {target_uuid = uuid}, function(ok, resp)
    if ok and show_tips then
      Util.show_message_tip(2082)
    end
  end)
end

function M:receive_all_friendship(uuid_list)
  local can_send = self:is_anybody_can_send()
  Network:call("c2gs_one_click_claim_all_reward", {uuid_list = uuid_list}, function(ok, resp)
    if ok then
      if can_send then
        Util.show_message_tip(2082)
        return
      end
      local is_receive_max = self:is_receive_max()
      local is_anybody_can_receive = self:is_anybody_can_receive()
      if is_receive_max and is_anybody_can_receive then
        Util.show_message_tip(2081)
      end
    end
  end)
end

function M:update_friendship_data(data)
  if not data then
    return
  end
  if data.get_friend_reward_list then
    self.v_can_receive_friendships = {}
    for i, v in ipairs(data.get_friend_reward_list) do
      self.v_can_receive_friendships[v] = true
    end
  end
  if data.send_friend_uuid_list then
    self.v_had_send_friendships = {}
    for i, v in ipairs(data.send_friend_uuid_list) do
      self.v_had_send_friendships[v.target_uuid] = v.send_cnt or 0
    end
  end
  self.v_had_send_count = data.send_cnt
  MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_SHIP)
end

function M:on_get_friend_persent(data)
  if not data or not data.target_uuid then
    return
  end
  self.v_can_receive_friendships[data.target_uuid] = true
end

function M:can_receive_friendship(uuid)
  return self.v_can_receive_friendships[uuid]
end

function M:can_send_friendship(uuid)
  local had_send_friendships_times = self.v_had_send_friendships[uuid] or 0
  return 0 == had_send_friendships_times
end

function M:get_had_send_times()
  return self.v_had_send_count
end

function M:is_receive_max()
  local max_times = ShareRes.get_system_comm_value("GetPresentRewardLimit")
  if max_times <= self.v_had_send_count then
    return false
  end
end

function M:is_anybody_can_receive()
  for _, v in pairs(self.v_can_receive_friendships) do
    if v then
      return true
    end
  end
end

function M:is_anybody_can_send()
  local friend_num = self:get_friend_num()
  local had_send = UtilTable.hash_lenth(self.v_had_send_friendships)
  return friend_num > had_send
end

function M:show_add_friend_tips(playerInfo)
  if not playerInfo then
    return
  end
  local is_friend = self:is_in_friend(playerInfo.uuid)
  if is_friend then
    return
  end
  local is_applying = self:check_applied_by_uuid(playerInfo.uuid)
  if is_applying then
    return
  end
  local cur_friend_num = self:get_friend_num()
  if cur_friend_num >= FRIEND_MAX_NUM then
    return
  end
  UIMgr:get_ui("add_friend_tips"):ui_show(playerInfo)
end

function M:hide_add_friend_tips()
  UIMgr:try_hide_ui("add_friend_tips")
end

function M:set_btn_cd_time(cd_time)
  self.v_btn_cd_time = cd_time
end

function M:get_btn_cd_time()
  return self.v_btn_cd_time or 0
end

function M:on_gs2c_update_recommend_player_status(data)
  local target_uuid = data.target_uuid
  if self.v_cache_applied_tag then
    self.v_cache_applied_tag[target_uuid] = false
  end
  if self.v_role_info and self.v_role_info[target_uuid] then
    self.v_role_info[target_uuid].friend_status = data.friend_status
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_FRIEND_STATE)
  msg.mm_x = target_uuid
end

return M
