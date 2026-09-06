local function p1(protocol)
  local userId = protocol.user.baseUserData.userId
  
  local oldIdentity
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(userId)
  if friend then
    oldIdentity = friend:GetIdentity()
  end
  NekoData.DataManager.DM_Friends:OnSRefreshFriendIdentity(userId, protocol.user.identity)
  friend = NekoData.DataManager.DM_Friends:OnSAddFriend(protocol)
  LogInfoFormat("sadduser", "userid %s: oldIdentity %s  newidentity %s", userId, oldIdentity, protocol.user.identity)
  if friend and friend:IsFriend() and NekoData.DataManager.DM_Friends:RemoveRecommendFriend(userId) then
    LuaNotificationCenter.PostNotification(Common.n_RemoveRecommendFriend, nil, userId)
  end
  local userinfo = {}
  userinfo.userid = userId
  userinfo.oldIdentity = oldIdentity
  userinfo.newIdentity = protocol.user.identity
  LuaNotificationCenter.PostNotification(Common.n_FriendIdentityChange, nil, userinfo)
  LuaNotificationCenter.PostNotification(Common.n_OnSRefreshOtherUserIdentity, nil, userinfo)
end

local function p2(protocol, client)
end

return {p1, p2}
