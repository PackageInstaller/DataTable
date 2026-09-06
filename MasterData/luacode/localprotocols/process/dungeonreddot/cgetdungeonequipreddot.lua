local CGetDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.cgetdungeonequipreddot")

function CGetDungeonEquipRedDot:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CGetDungeonEquipRedDot Process")
  end
  SqlConnection.GetDungeonEquipRedDotKey(self.clientId)
end

return CGetDungeonEquipRedDot
