local CStoreDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.cstoredungeonequipreddot")

function CStoreDungeonEquipRedDot:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CStoreDungeonEquipRedDot Process")
  end
  SqlConnection.StoreDungeonEquipRedDotKey(self.clientId, self.redDotData)
end

return CStoreDungeonEquipRedDot
