local CDeleteDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.cdeletedungeonequipreddot")

function CDeleteDungeonEquipRedDot:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CDeleteDungeonEquipRedDot Process")
  end
  SqlConnection.RemoveDungeonEquipRedDotKeyTable(self.clientId)
end

return CDeleteDungeonEquipRedDot
