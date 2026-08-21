local Base = require("gamelogic.base_system")
local UnionCfg = require("uimodule.union.union_config")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.v_union_gid = 0
  self.v_is_leader = false
  self.v_union_info = false
end

function M:on_reconnect()
  self:_clear_union_data()
end

function M:on_guild_state(data)
  local need_publish = self.v_union_gid ~= data.gid
  self.v_union_gid = data.gid
  if need_publish then
    self:_clear_union_data()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_HAS_UNION_STATE_UPDATE)
    msg.mm_x = self.v_union_gid > 0
  end
  if 0 == self.v_union_gid then
    return
  end
  local is_leader = data.position == UnionCfg.UNION_TITLE.CHAIRMAN
  need_publish = is_leader ~= self.v_is_leader
  if self.v_is_leader == true and false == is_leader then
    self.v_applicants = {}
    self:refresh_application_redpoint()
  end
  self.v_is_leader = is_leader
  if need_publish then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_UNION_TITLE_UPDATE)
    msg.mm_x = self.v_is_leader
  end
end

function M:on_guild_memeber_num_change(data)
  self.v_union_info.member_num = data.mem_num
end

function M:_clear_union_data()
  self.v_union_info = nil
  self.v_is_leader = false
  self.v_union_leader = nil
  ChatMgr:clear_guild_msg()
  self.v_union_invitations = {}
  self:refresh_invation_redpoint()
  self.v_applicants = {}
  self:refresh_application_redpoint()
end

function M:request_get_union_info(cb)
  local need_delay = self.v_union_info ~= nil
  ScreenMaskMgr:open_one_tag("c2gs_get_own_guild_info", math.huge, need_delay)
  Network:call("c2gs_get_own_guild_info", {}, function(ok, resp)
    ScreenMaskMgr:close_one_tag("c2gs_get_own_guild_info")
    if ok then
      self.v_is_leader = Global.player_uuid == resp.chairman_uuid
      self.v_union_leader = resp.members[resp.chairman_uuid]
      local tb = resp
      local ret = {}
      for _, v in pairs(resp.members) do
        table.insert(ret, v)
      end
      tb.members = ret
      tb.member_num = #tb.members
      tb.member_num_limit = ShareRes.create("guild.guild_upgrade", 1).MemberNumLimit
      self.v_union_info = tb
      if cb then
        cb(true)
      end
      MsgGame:mq_publish2(Const.MSG_ON_UNION_INFO_UPDATE)
    end
  end)
end

function M:request_get_recommend_unions(cb)
  if self.v_get_unions and Date.server_time() - self.v_get_unions < UnionCfg.INVITE_LIST_REFRESH_CD then
    if cb then
      cb(self.v_recommend_unions)
    end
    return
  end
  self.v_get_unions = Date.server_time()
  Network:call("c2gs_guild_get_recommend_guild", {}, function(ok, resp)
    if ok then
      self.v_recommend_unions = resp.recommend_list
      if cb then
        cb(self.v_recommend_unions)
      end
    end
  end)
end

function M:request_search_recommend_unions(serach_str, cb)
  ScreenMaskMgr:open_one_tag("c2gs_search_guild", math.huge, false)
  local send_data = {name = serach_str}
  Network:call("c2gs_search_guild", send_data, function(ok, resp)
    ScreenMaskMgr:close_one_tag("c2gs_search_guild")
    if ok then
      local list = resp.guild_list
      local len = #list
      if 0 == len then
        Util.show_message_tip(2099)
      end
      if cb and len > 0 then
        cb(list)
      end
    end
  end)
end

function M:request_join_union(union_gid, cb)
  Network:call("c2gs_guild_apply_join", {gid = union_gid}, function(ok, resp)
    for _, v in ipairs(self.v_recommend_unions) do
      if v.gid == union_gid then
        if resp.verify_type then
          v.verify_type = resp.verify_type
        end
        v.apply_status = 1
        break
      end
    end
    if cb then
      cb(ok)
    end
  end)
end

function M:request_create_union(icon, name, idea, verify_type, cb)
  local send_data = {
    icon = icon,
    name = name,
    idea = idea,
    verify_type = verify_type
  }
  ScreenMaskMgr:open_one_tag("c2gs_guild_create", math.huge)
  Network:call("c2gs_guild_create", send_data, function(ok, resp)
    ScreenMaskMgr:close_one_tag("c2gs_guild_create")
    if cb then
      cb(resp.errcode)
    end
  end)
end

function M:request_get_join_union_invitations(cb)
  Network:call("c2gs_guild_get_invite_info", {}, function(ok, resp)
    if ok then
      self.v_union_invitations = resp.invite_list
      if cb then
        cb()
      end
      self:refresh_invation_redpoint()
    end
  end)
end

function M:request_handle_invitaion(handle_type, data, cb)
  local type_info = UnionCfg.HANDLE_INVITE_PROTO_TYPE[handle_type]
  local protocol_name = type_info.proto_name
  local send_key = type_info.send_key
  local send_data = {
    [send_key] = data
  }
  Network:call(protocol_name, send_data, function(ok, resp)
    for i, v in ipairs(self.v_union_invitations) do
      if v.invite_uuid == data then
        table.remove(self.v_union_invitations, i)
        break
      end
    end
    if cb then
      cb(ok)
    end
    self:refresh_invation_redpoint()
  end)
end

function M:request_kickout_member(uuid, cb)
  local send_data = {target_uuid = uuid}
  Network:call("c2gs_guild_kick_out_role", send_data, function(ok, resp)
    if ok and cb then
      cb()
    end
    for i, v in ipairs(self.v_union_info.members) do
      if v.uuid == uuid then
        table.remove(self.v_union_info.members, i)
        break
      end
    end
    MsgGame:mq_publish2(Const.MSG_ON_UNION_MEMBER_DELET)
  end)
end

function M:request_transfer_leader(uuid, cb)
  local send_data = {target_uuid = uuid}
  Network:call("c2gs_guild_transfer_chairman", send_data, function(ok, resp)
    if ok and cb then
      cb()
    end
  end)
end

function M:request_change_union_info(change_type, change_data, cb)
  local type_info = UnionCfg.CHANGE_INFO_PRPTO_TYPE[change_type]
  local protocol_name = type_info.proto_name
  local send_key = type_info.send_key
  local info_key = type_info.info_key
  local send_data = {
    [send_key] = change_data
  }
  Network:call(protocol_name, send_data, function(ok, resp)
    if ok then
      self.v_union_info[info_key] = change_data
    end
    if cb then
      cb(ok)
    end
  end)
end

function M:request_get_no_union_players(cb)
  if self.v_get_players and Date.server_time() - self.v_get_players < UnionCfg.INVITE_LIST_REFRESH_CD then
    if cb then
      cb(self.v_no_union_players)
    end
    return
  end
  self.v_get_players = Date.server_time()
  Network:call("c2gs_guild_get_recommend_role", {}, function(ok, resp)
    if ok then
      self.v_no_union_players = resp.recommend_list
      if cb then
        cb(self.v_no_union_players)
      end
    end
  end)
end

function M:request_search_no_union_players(target_uuid, target_name, cb)
  ScreenMaskMgr:open_one_tag("c2gs_guild_invite_search_role", math.huge)
  Network:call("c2gs_guild_invite_search_role", {target_uuid = target_uuid, target_name = target_name}, function(ok, resp)
    ScreenMaskMgr:close_one_tag("c2gs_guild_invite_search_role")
    if ok then
      local list = resp.role_list
      if 0 == #list then
        Util.show_message_tip(2101)
        return
      end
      if cb then
        cb(list)
      end
    end
  end)
end

function M:request_invite_player(uuid, cb)
  local send_data = {target_uuid = uuid}
  Network:call("c2gs_guild_invite_role", send_data, function(ok, resp)
    if ok and cb then
      cb(true)
    end
  end)
end

function M:request_get_join_union_applicants(cb)
  Network:call("c2gs_guild_get_apply_list", {}, function(ok, resp)
    self.v_applicants = resp.apply_list
    if ok and cb then
      cb()
    end
    self:refresh_application_redpoint()
  end)
end

function M:request_handle_union_apply(handle_type, data, cb)
  local type_info = UnionCfg.HANDLE_APPLY_PROTO_TYPE[handle_type]
  local protocol_name = type_info.proto_name
  local send_key = type_info.send_key
  local send_data = {
    [send_key] = data
  }
  Network:call(protocol_name, send_data, function(ok, resp)
    local player_info
    for i, v in ipairs(self.v_applicants) do
      if v.applicant_info.uuid == data then
        player_info = v.applicant_info
        table.remove(self.v_applicants, i)
        break
      end
    end
    if ok and handle_type == UnionCfg.HANDLE_APPLY_TYPE.ACCEPT and player_info then
      local str = Util.format_str("{1}成功加入公会！", player_info.name)
      UIMgr:get_ui("uimessagetip"):ui_show(str)
    end
    local msg = MsgGame:mq_publish2(Const.MSG_ON_UNION_APPLY_HANDLED)
    msg.mm_x = handle_type
    self:refresh_application_redpoint()
  end)
end

function M:request_quit_union(cb)
  Network:call("c2gs_quit_guild", {}, function(ok, resp)
    if ok then
      self.v_union_info = nil
      if cb then
        cb(true)
      end
      MsgGame:mq_publish2(Const.MSG_ON_UNION_MEMBER_DELET)
    end
  end)
end

function M:request_check_member(target_uuid, cb)
  Network:call("c2gs_check_role_in_own_guild", {target_uuid = target_uuid}, function(ok, resp)
    if ok then
      if cb then
        cb(resp.is_member)
      end
      if not resp.is_member then
        MsgGame:mq_publish2(Const.MSG_ON_UNION_MEMBER_DELET)
      end
    end
  end)
end

function M:request_union_online_num(cb)
  Network:call("c2gs_guild_online_num", {}, function(ok, resp)
    if ok and cb then
      cb(resp.online_num)
    end
  end)
end

function M:get_is_union_leader()
  return self.v_is_leader
end

function M:get_invitation_list()
  return self.v_union_invitations or {}
end

function M:get_member_list()
  if not self.v_union_info then
    return {}
  end
  return self.v_union_info.members
end

function M:get_union_list()
  return self.v_recommend_unions
end

function M:get_player_list()
  return self.v_no_union_players or {}
end

function M:get_join_union_appliants()
  return self.v_applicants
end

function M:get_is_union_full()
  return self.v_union_info.member_num >= self.v_union_info.member_num_limit
end

function M:get_in_union()
  return self.v_union_gid > 0
end

function M:get_union_info()
  return self.v_union_info
end

function M:get_leader_info()
  return self.v_union_leader
end

function M:refresh_application_redpoint()
  self.v_show_application_redpoint = self.v_applicants and #self.v_applicants > 0
  RedPointMgr:enable_redpoint(RedEnum.JION_UNION_APPLY, self.v_show_application_redpoint)
end

function M:refresh_invation_redpoint()
  self.v_show_invitation_redpoint = self.v_union_invitations and #self.v_union_invitations > 0
  RedPointMgr:enable_redpoint(RedEnum.JION_UNION_INVITE, self.v_show_invitation_redpoint)
end

function M:refresh_redpoint()
  RedPointMgr:enable_redpoint(RedEnum.JION_UNION_APPLY, self.v_show_application_redpoint)
  RedPointMgr:enable_redpoint(RedEnum.JION_UNION_INVITE, self.v_show_invitation_redpoint)
  if self.v_union_gid > 0 then
    self:request_get_union_info()
  end
end

function M:get_union_join_mode()
  return self.v_union_info.verify_type
end

function M:get_my_union_title()
  return self.v_is_leader and UnionCfg.UNION_TITLE.CHAIRMAN or UnionCfg.UNION_TITLE.NORMAL_MEMBER
end

function M:show_invitation_redpoint()
  self.v_show_invitation_redpoint = true
  if not UIMgr:try_get_visible_ui("union_main") then
    RedPointMgr:enable_redpoint(RedEnum.JION_UNION_INVITE, self.v_show_invitation_redpoint)
  end
end

function M:show_application_redpoint()
  self.v_show_application_redpoint = true
  if not UIMgr:try_get_visible_ui("union_main") then
    RedPointMgr:enable_redpoint(RedEnum.JION_UNION_APPLY, self.v_show_application_redpoint)
  end
end

return M
