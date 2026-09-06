local CCloseDataBase = require("localprotocols.def.friendchat.cclosedatabase")

function CCloseDataBase:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CCloseDataBase Process")
  end
  SqlConnection.UnInit()
end

return CCloseDataBase
