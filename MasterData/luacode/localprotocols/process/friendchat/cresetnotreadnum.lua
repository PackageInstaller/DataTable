local CResetNotReadNum = require("localprotocols.def.friendchat.cresetnotreadnum")

function CResetNotReadNum:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CResetNotReadNum Process")
  end
  SqlConnection.ResetNotReadNum(self.userId)
end

return CResetNotReadNum
