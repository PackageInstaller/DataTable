local Base = require("gamelogic.activity.activity")
local CommonDefine = require("cs_share.common_define")
local OnlineConfig = require("gamelogic.activity.online_config")
local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local Act_ID = CommonDefine.ACTY_TYPE.ONLINE_BATTLE
local ROOM_CHANGE_TYPE = CommonDefine.ROOM_CHANGE_TYPE
local ROOM_ABOUT_MAP = CommonDefine.ROOM_ABOUT_MAP
local M = Util.create_child_mt(Base)

function M:_init(activity_id, config_id)
  self.online_cfg = ShareRes.create("activity.online_battle", config_id)
  self.v_game_id = self.online_cfg.Id
  self.v_stage_list = {}
  Base._init(self, activity_id, self.online_cfg.ActyTimeId)
  self.v_invited_list = {}
  self.v_invite_list = {}
  self:sys_mq_bind(Const.MSG_ON_SHOW_UI, self.on_ui_show_event, self)
  self:sys_mq_bind(Const.MSG_ON_HIDE_UI, self._response_hide_event, self)
end

function M:on_ui_show_event(msg)
  local ui_name = msg.mm_obj
  if "uimain" ~= ui_name then
    return
  end
  if not self.v_check_login then
    self:_check_open_match_team()
  end
  self:_check_invition(msg)
end

function M:_check_open_match_team()
  self.v_check_login = true
  if not self.v_match_room_info then
    return
  end
  UIMgr:get_ui("online_team"):ui_show(self.v_match_room_info.epi_id)
end

function M:_check_invition(msg)
  if 0 == #self.v_invite_list then
    return
  end
  UIMgr:get_ui("online_battle_match_tips"):ui_show(OnlineConfig.Quick_TIPS_TYPE.INVITATION)
end

function M:_response_hide_event(msg)
  local ui_name = msg.mm_obj
  if "uimain" ~= ui_name then
    return
  end
  UIMgr:try_hide_ui("online_battle_match_tips")
end

function M:update(delta_time)
  if self.v_waiting_math then
    local wait_time = GlobalTimeMgr:get_unscaled_time() - self.v_join_match_time
    if wait_time > self.online_cfg.MatchTime then
      self:request_quit_match()
      self:_clear_match_info()
    end
  end
  if self.v_invited_list then
    for uuid, time in pairs(self.v_invited_list) do
      if GlobalTimeMgr:get_unscaled_time() - time > self.online_cfg.InvitePlayerCD then
        self.v_invited_list[uuid] = nil
        local msg = MsgGame:mq_publish2(Const.MSG_ON_INVITE_FRIEND_CD_FINISH)
        msg.mm_obj = uuid
      end
    end
  end
  if self.v_invite_all_time and GlobalTimeMgr:get_unscaled_time() - self.v_invite_all_time > self.online_cfg.InvitePlayerCD then
    self.v_invite_all_time = nil
    local msg = MsgGame:mq_publish2(Const.MSG_ON_INVITE_FRIEND_CD_FINISH)
    msg.mm_obj = -1
  end
  if #self.v_invite_list > 0 then
    local time = self.v_invite_list[1].time
    if GlobalTimeMgr:get_unscaled_time() - time > self.online_cfg.InviteContinuTime then
      table.remove(self.v_invite_list, 1)
      MsgGame:mq_publish2(Const.MSG_ON_BE_INVITE_CD_FINISH)
    end
  end
end

function M:on_online_battle_list(data)
  self.v_stage_list = data.online_battle_list
end

function M:on_online_battle_data(data)
  local info = data.online_battle_data
  self.v_stage_list[info.id] = info
end

function M:on_roominfo(data)
  self.v_match_room_info = {}
  self.v_match_room_info.match = data.match
  self.v_match_room_info.epi_id = data.epi_id
  self.v_match_room_info.activity_id = data.activity_id
  self.v_match_room_info.playerlist = {
    [1] = true
  }
  for _, v in ipairs(data.playerlist) do
    if v.uuid == Global.player_uuid then
      self.v_match_room_info.playerlist[1] = v
    else
      table.insert(self.v_match_room_info.playerlist, v)
    end
  end
  UIMgr:try_hide_ui("online_battle_match_tips")
  UIMgr:try_hide_ui("online_battle_point")
  UIMgr:get_ui("online_team"):ui_show(data.epi_id)
  self.v_waiting_math = nil
  self.v_join_match_time = nil
  self.v_matching_epi_id = nil
  MsgGame:mq_publish2(Const.MSG_ON_MATCH_ROOM_UPDATE)
end

function M:on_change_room(data)
  if data.change_key == ROOM_CHANGE_TYPE.PLAYER_STATE then
    for _, v in ipairs(self.v_match_room_info.playerlist) do
      if v.uuid == data.uuid then
        v.state = data.change_val
        MsgGame:mq_publish2(Const.MSG_ON_MATCH_ROOM_UPDATE)
        break
      end
    end
  end
end

function M:on_player_roomadd(data)
  if not self.v_match_room_info then
    return
  end
  local member_list = self.v_match_room_info.playerlist
  if not member_list then
    self.v_match_room_info.playerlist = {}
    member_list = self.v_match_room_info.playerlist
  end
  table.insert(member_list, data.playerdata)
  MsgGame:mq_publish2(Const.MSG_ON_MATCH_ROOM_MEMBER_CHANGE)
end

function M:on_player_roomdel(data)
  if not self.v_match_room_info then
    Log.Error("M:on_player_roomdel room_info is nil")
    return
  end
  local member_list = self.v_match_room_info.playerlist
  if not member_list then
    Log.Error("M:on_player_roomdel member list is nil")
    return
  end
  for i, v in ipairs(member_list) do
    if v.uuid == data.uuid then
      table.remove(member_list, i)
      break
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_MATCH_ROOM_MEMBER_CHANGE)
end

function M:on_invite_message(data)
  table.insert(self.v_invite_list, {
    info = data,
    time = GlobalTimeMgr:get_unscaled_time()
  })
  table.sort(self.v_invite_list, function(a, b)
    return a.time < b.time
  end)
  local main_ui = UIMgr:try_get_visible_ui("uimain")
  if not main_ui then
    return
  end
  local canvas = main_ui:get_canvas()
  if 0 == canvas.planeDistance then
    return
  end
  UIMgr:get_ui("online_battle_match_tips"):ui_show(OnlineConfig.Quick_TIPS_TYPE.INVITATION, {need_tween = true})
end

function M:on_enterwar_room(data)
  self.v_fight_info = data
end

function M:on_match_exit(data)
  self.v_match_room_info = nil
end

function M:on_room_changebuddy(data)
  if not self.v_match_room_info then
    Log.Error("M:on_player_roomdel room_info is nil")
    return
  end
  local member_list = self.v_match_room_info.playerlist
  if not member_list then
    Log.Error("M:on_player_roomdel member list is nil")
    return
  end
  local member_info
  for _, v in ipairs(member_list) do
    if v.uuid == data.uuid then
      member_info = v
      break
    end
  end
  if not member_info then
    Log.Error("M:on_player_roomdel member is nil", data.uuid)
    return
  end
  member_info.buddy_info = data.buddy_info
  MsgGame:mq_publish2(Const.MSG_ON_MATCH_ROOM_UPDATE)
end

function M:on_system_leaveroom(data)
  self:_clear_match_info()
  UIMgr:try_hide_ui("online_team")
  local lab
  if data.leave_type == ROOM_ABOUT_MAP.LEAVE_TYPE.SYSTEM_KICKOUT then
    lab = Util.format_str("长时间未开始战斗，已被请离房间")
  else
    lab = Util.format_str("已被请离房间")
  end
  UIMgr:get_ui("online_battle_tips"):ui_show(OnlineConfig.Notice_TIPS_TYPE.ROOM, {lab = lab})
  MsgGame:mq_publish2(Const.MSG_ON_KICK_OUT_ROOM)
end

function M:on_kickout_capatin_countdown(data)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_CUT_DOWN_UPDATE)
  msg.mm_x = 1 == data.countdown_type
  msg.mm_y = data.second
end

function M:on_room_change_capatin(data)
  for _, v in ipairs(self.v_match_room_info.playerlist) do
    if v.pos == ROOM_ABOUT_MAP.POS_MAP.CAPATIN_POS then
      v.state = data.old_capatin_state
    end
  end
  for _, v in ipairs(self.v_match_room_info.playerlist) do
    if v.uuid == data.new_capatin_uuid then
      v.pos = ROOM_ABOUT_MAP.POS_MAP.CAPATIN_POS
      v.state = data.new_capatin_state
    else
      v.pos = ROOM_ABOUT_MAP.POS_MAP.MENBER_POS
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_MATCH_ROOM_UPDATE)
end

function M:request_change_roomstate(change_key, change_val, callback)
  if not self:_check_state(change_key, change_val) then
    return
  end
  local send_data = {change_key = change_key, change_val = change_val}
  Network:call("c2gs_change_roomstate", send_data, function(ok, resp)
    if ok then
      self:_sync_room_state(change_key, change_val)
      if callback then
        callback()
      end
    end
  end)
end

function M:_check_state(change_key, change_val)
  if not self.v_match_room_info then
    return false
  end
  if change_key == ROOM_CHANGE_TYPE.ROOM_AUTOMATCH then
    return self.v_match_room_info.match ~= change_val
  elseif change_key == ROOM_CHANGE_TYPE.ROLE_ID then
    return true
  else
    local player_info = self.v_match_room_info.playerlist[1]
    return player_info.state ~= change_val
  end
end

function M:_sync_room_state(change_key, change_val)
  if not self.v_match_room_info then
    return
  end
  if change_key == ROOM_CHANGE_TYPE.ROOM_AUTOMATCH then
    self.v_match_room_info.match = change_val
  elseif change_key == ROOM_CHANGE_TYPE.ROLE_ID then
    for _, v in ipairs(self.v_match_room_info.playerlist) do
      local role_id = v.buddy_info.id
      if role_id == change_val then
        self:_set_player_state(ROOM_ABOUT_MAP.STATE_MAP.NOT_READY)
        Util.show_message_tip(2044)
      end
    end
  else
    self:_set_player_state(change_val)
  end
end

function M:_set_player_state(state)
  local player_info = self.v_match_room_info.playerlist[1]
  player_info.state = state
  local msg = MsgGame:mq_publish2(Const.MSG_ON_PLAYER_STATE_UPDATE)
  msg.mm_x = player_info.uuid
end

function M:request_invite_player(invite_type, uuid, callback)
  local send_data = {invite_type = invite_type, uuid = uuid}
  Network:call("c2gs_invite_player", send_data, function(ok, resp)
    if ok and 0 == resp.errcode then
      for _, v in ipairs(resp.uuidlist) do
        self.v_invited_list[v] = GlobalTimeMgr:get_unscaled_time()
      end
      if callback then
        callback()
      end
    end
  end)
end

function M:request_invite_accept(id, callback)
  local send_data = {id = id}
  Network:call("c2gs_invite_accept", send_data, function(ok, resp)
    if ok then
      if callback then
        callback()
      end
      for i, v in ipairs(self.v_invite_list) do
        if v.info.id == id then
          table.remove(self.v_invite_list, i)
          return
        end
      end
    end
  end)
end

function M:request_leave_room(callback)
  Network:call("c2gs_leave_room", {}, function(ok, resp)
    if ok then
      if callback then
        callback()
      end
      self.v_match_room_info = nil
    end
  end)
end

function M:request_create_room(epi_id, limit_lv, callback)
  local send_data = {
    activity_id = self.v_game_id,
    epi_id = epi_id,
    limit_lv = limit_lv,
    auto_match = UnityPlayerPrefs.GetInt("auto_match_remmber", 0)
  }
  Network:call("c2gs_create_room", send_data, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:request_joinwar_room(callback)
  Network:call("c2gs_joinwar_room", {}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:request_join_match(epi_id, callback)
  local send_data = {
    activity_id = self.v_game_id,
    epi_id = epi_id
  }
  Network:call("c2gs_join_match", send_data, function(ok, resp)
    if ok then
      self.v_waiting_math = true
      self.v_matching_epi_id = epi_id
      self.v_join_match_time = GlobalTimeMgr:get_unscaled_time()
      MsgGame:mq_publish2(Const.MSG_ON_ENTER_MATCH_QUEUE)
      if callback then
        callback()
      end
    end
  end)
end

function M:request_quit_match(callback)
  Network:call("c2gs_quit_match", {}, function(ok, resp)
    if ok then
      if callback then
        callback()
      end
      self:_clear_match_info()
      MsgGame:mq_publish2(Const.MSG_ON_QUIT_MATCH_QUEUE)
    end
  end)
end

function M:request_kickout_player(uuid, callback)
  Network:call("c2gs_kickout_player", {uuid = uuid}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:request_room_transfer_capatin(uuid, callback)
  Network:call("c2gs_room_transfer_capatin", {uuid = uuid}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:get_act_cfg()
  return self.online_cfg
end

function M:get_game_id()
  return self.v_game_id
end

function M:get_has_pass_point(point_id)
  if self.v_stage_list[point_id] then
    return self.v_stage_list[point_id].customs
  end
  return false
end

function M:get_in_matching()
  return self.v_waiting_math
end

function M:get_join_match_time()
  return self.v_join_match_time
end

function M:get_cur_match_point()
  return self.v_matching_epi_id
end

function M:get_invitation_list()
  return self.v_invite_list
end

function M:refuse_match_invited(invited_id)
  if 0 == #self.v_invite_list then
    return
  end
  for i, v in ipairs(self.v_invite_list) do
    if v.info.id == invited_id then
      table.remove(self.v_invite_list, i)
      return
    end
  end
end

function M:_clear_match_info()
  self.v_waiting_math = nil
  self.v_match_room_info = nil
  self.v_join_match_time = nil
  self.v_matching_epi_id = nil
end

function M:get_hero_list()
  if not self.v_match_room_info or next(self.v_match_room_info.playerlist) == nil then
    return {}
  end
  return self.v_match_room_info.playerlist
end

function M:get_match_room_info()
  return self.v_match_room_info
end

function M:get_is_leader()
  if not self.v_match_room_info or next(self.v_match_room_info.playerlist) == nil then
    return false
  end
  for _, v in ipairs(self.v_match_room_info.playerlist) do
    if v.uuid == Global.player_uuid and v.pos == ROOM_ABOUT_MAP.POS_MAP.CAPATIN_POS then
      return true
    end
  end
  return false
end

function M:invite_friend(uuid, callback)
  self:request_invite_player(ROOM_ABOUT_MAP.INVITE_TYPE.SINGLE_FRIEND, uuid, callback)
end

function M:invite_all_friend(callback)
  self.v_invite_all_time = GlobalTimeMgr:get_unscaled_time()
  self:request_invite_player(ROOM_ABOUT_MAP.INVITE_TYPE.ALL_FRIEND, 0, callback)
end

function M:get_invite_all_friend()
  return self.v_invite_all_time ~= nil
end

function M:get_invite_friend(uuid)
  return self.v_invited_list[uuid] ~= nil
end

return M
