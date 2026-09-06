local CDeleteDungeonEquipRedDotOneLine = require("localprotocols.def.dungeonreddot.cdeletedungeonequipreddotoneline")

function CDeleteDungeonEquipRedDotOneLine:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CDeleteDungeonEquipRedDotOneLine Process")
  end
  SqlConnection.DeleteOneLineDungeonEquipRedDotKey(self.clientId, self.roleKey, self.equipKey)
end

return CDeleteDungeonEquipRedDotOneLine
