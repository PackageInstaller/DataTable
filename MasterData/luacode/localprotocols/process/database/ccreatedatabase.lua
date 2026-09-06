local CCreateDataBase = require("localprotocols.def.database.ccreatedatabase")

function CCreateDataBase:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CCreateDataBase Process")
  end
  SqlConnection.Init(self.userId, self.clientId)
end

return CCreateDataBase
