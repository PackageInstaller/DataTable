local SGetLocalChatInfo = require("localprotocols.def.friendchat.sgetlocalchatinfo")

function SGetLocalChatInfo:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SGetLocalChatInfo Process")
  end
  NekoData.DataManager.DM_FriendsChat:OnSGetLocalChatInfo(self)
end

return SGetLocalChatInfo
