local function p1(protocol)
  NekoData.DataManager.DM_FriendsChat:OnSAddFriendChat(protocol)
  
  local dialog = DialogManager.GetDialog("friend.friendslistdialog")
  if dialog and dialog:IsActive() and dialog:GetSelectedFriend() == protocol.userId then
  else
    local userInfo = {}
    userInfo.userId = protocol.userId
    LuaNotificationCenter.PostNotification(Common.n_FriendNotReadNumChange, nil, userInfo)
    NekoData.DataManager.DM_Friends:CheckFriendPageRedData()
  end
  LuaNotificationCenter.PostNotification(Common.n_FriendChatReceive, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
