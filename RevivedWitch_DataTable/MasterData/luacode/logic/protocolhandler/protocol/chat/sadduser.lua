-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/chat/sadduser.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local userId = ((protocol.user).baseUserData).userId
  local oldIdentity = nil
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend(userId)
  if friend then
    oldIdentity = friend:GetIdentity()
  end
  ;
  ((NekoData.DataManager).DM_Friends):OnSRefreshFriendIdentity(userId, (protocol.user).identity)
  friend = ((NekoData.DataManager).DM_Friends):OnSAddFriend(protocol)
  LogInfoFormat("sadduser", "userid %s: oldIdentity %s  newidentity %s", userId, oldIdentity, (protocol.user).identity)
  if friend and friend:IsFriend() and ((NekoData.DataManager).DM_Friends):RemoveRecommendFriend(userId) then
    (LuaNotificationCenter.PostNotification)(Common.n_RemoveRecommendFriend, nil, userId)
  end
  local userinfo = {}
  userinfo.userid = userId
  userinfo.oldIdentity = oldIdentity
  userinfo.newIdentity = (protocol.user).identity
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_FriendIdentityChange, nil, userinfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnSRefreshOtherUserIdentity, nil, userinfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

