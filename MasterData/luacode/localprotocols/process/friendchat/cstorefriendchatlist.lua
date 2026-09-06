local CStoreFriendChatList = require("localprotocols.def.friendchat.cstorefriendchatlist")

function CStoreFriendChatList:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CStoreFriendChatList Process")
  end
  SqlConnection.StoreMsgList(self.userId, self.msgs)
end

return CStoreFriendChatList
