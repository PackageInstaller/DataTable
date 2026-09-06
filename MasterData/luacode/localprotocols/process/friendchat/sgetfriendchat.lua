local SGetFriendChat = require("localprotocols.def.friendchat.sgetfriendchat")

function SGetFriendChat:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SGetFriendChat Process")
  end
  NekoData.DataManager.DM_FriendsChat:OnSGetFriendChat(self)
  NekoData.DataManager.DM_Friends:CheckFriendPageRedData()
  LuaNotificationCenter.PostNotification(Common.n_FriendLocalChatReceive, nil, self)
end

return SGetFriendChat
