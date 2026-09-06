local CGetFriendChat = require("localprotocols.def.friendchat.cgetfriendchat")

function CGetFriendChat:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CGetFriendChat Process")
  end
  SqlConnection.GetMsg(self.userId, self.beginId, self.endId)
end

return CGetFriendChat
