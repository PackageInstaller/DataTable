-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/chat/srefreshotheruseridentity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local OtherUserInfo = (LuaNetManager.GetBeanDef)("protocol.chat.otheruserinfo")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : OtherUserInfo, _ENV
  if protocol.identity == OtherUserInfo.ADD then
    if ((NekoData.DataManager).DM_Friends):RemoveRecommendFriend(protocol.userId) then
      (LuaNotificationCenter.PostNotification)(Common.n_RemoveRecommendFriend, nil, protocol.userId)
    end
    return 
  end
  ;
  (((NekoData.BehaviorManager).BM_Friends):GetFriend(protocol.userId))
  local friendOld = nil
  local oldIdentity = nil
  if friendOld then
    oldIdentity = friendOld:GetIdentity()
    ;
    ((NekoData.DataManager).DM_Friends):OnSRefreshFriendIdentity(protocol.userId, protocol.identity)
    local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend(protocol.userId)
    if friend and (friend:IsBlack() or friend:IsStranger()) then
      ((NekoData.DataManager).DM_FriendsChat):RemoveFriendLocalChat(protocol.userId)
    end
    if friend and friend:IsFriend() and ((NekoData.DataManager).DM_Friends):RemoveRecommendFriend(protocol.userId) then
      (LuaNotificationCenter.PostNotification)(Common.n_RemoveRecommendFriend, nil, protocol.userId)
    end
    local userinfo = {}
    userinfo.userid = protocol.userId
    userinfo.oldIdentity = oldIdentity
    userinfo.newIdentity = protocol.identity
    LogInfoFormat("srefreshotheruseridentity", "userid %s: identity old %s new %s", protocol.userId, oldIdentity, protocol.identity)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_FriendIdentityChange, nil, userinfo)
  end
  do
    local userinfo = {}
    userinfo.userid = protocol.userId
    userinfo.newIdentity = protocol.identity
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSRefreshOtherUserIdentity, nil, userinfo)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

