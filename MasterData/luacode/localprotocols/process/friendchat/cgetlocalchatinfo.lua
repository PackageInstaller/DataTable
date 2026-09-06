local CGetLocalChatInfo = require("localprotocols.def.friendchat.cgetlocalchatinfo")

function CGetLocalChatInfo:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CGetLocalChatInfo Process")
  end
  SqlConnection.GetLocalChatInfo(self.userId)
end

return CGetLocalChatInfo
