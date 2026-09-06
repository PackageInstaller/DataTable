local OtherUserInfo = LuaNetManager.GetBeanDef("protocol.chat.otheruserinfo")

local function p1(protocol)
  if protocol.identity == OtherUserInfo.ADD then
    if NekoData.DataManager.DM_Friends:RemoveRecommendFriend(protocol.userId) then
      LuaNotificationCenter.PostNotification(Common.n_RemoveRecommendFriend, nil, protocol.userId)
    end
    return
  end
  local friendOld = NekoData.BehaviorManager.BM_Friends:GetFriend(protocol.userId)
  local oldIdentity
  if friendOld then
    oldIdentity = friendOld:GetIdentity()
    NekoData.DataManager.DM_Friends:OnSRefreshFriendIdentity(protocol.userId, protocol.identity)
    local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(protocol.userId)
    if friend and (friend:IsBlack() or friend:IsStranger()) then
      NekoData.DataManager.DM_FriendsChat:RemoveFriendLocalChat(protocol.userId)
    end
    if friend and friend:IsFriend() and NekoData.DataManager.DM_Friends:RemoveRecommendFriend(protocol.userId) then
      LuaNotificationCenter.PostNotification(Common.n_RemoveRecommendFriend, nil, protocol.userId)
    end
    local userinfo = {}
    userinfo.userid = protocol.userId
    userinfo.oldIdentity = oldIdentity
    userinfo.newIdentity = protocol.identity
    LogInfoFormat("srefreshotheruseridentity", "userid %s: identity old %s new %s", protocol.userId, oldIdentity, protocol.identity)
    LuaNotificationCenter.PostNotification(Common.n_FriendIdentityChange, nil, userinfo)
  end
  local userinfo = {}
  userinfo.userid = protocol.userId
  userinfo.newIdentity = protocol.identity
  LuaNotificationCenter.PostNotification(Common.n_OnSRefreshOtherUserIdentity, nil, userinfo)
end

local function p2(protocol, client)
end

return {p1, p2}
