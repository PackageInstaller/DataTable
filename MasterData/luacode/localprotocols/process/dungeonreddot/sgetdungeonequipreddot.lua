local SGetDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.sgetdungeonequipreddot")

function SGetDungeonEquipRedDot:Process()
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SGetDungeonEquipRedDot Process")
  end
  NekoData.DataManager.DM_Dungeon:OnSGetDungeonEquipRedDot_LocalProtocol(self)
  LuaNotificationCenter.PostNotification(Common.n_DungeonEquipRedDot, self, nil)
end

return SGetDungeonEquipRedDot
