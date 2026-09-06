local CStoreFriendChat = require("localprotocols.def.friendchat.cstorefriendchat")

function CStoreFriendChat:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CStoreFriendChat Process")
  end
  SqlConnection.StoreMsg(self.userId, self.msg)
end

return CStoreFriendChat
