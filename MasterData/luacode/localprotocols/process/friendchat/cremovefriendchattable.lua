local CRemoveFriendChatTable = require("localprotocols.def.friendchat.cremovefriendchattable")

function CRemoveFriendChatTable:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CRemoveFriendChatTable Process")
  end
  SqlConnection.RemoveFriendChatTable(self.userId)
end

return CRemoveFriendChatTable
