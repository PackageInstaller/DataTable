local CCloseDataBase = require("localprotocols.def.database.cclosedatabase")

function CCloseDataBase:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CCloseDataBase Process")
  end
  SqlConnection.UnInit()
end

return CCloseDataBase
