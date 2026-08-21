-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/dungeonreddot/sgetdungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SGetDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.sgetdungeonequipreddot")
SGetDungeonEquipRedDot.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SGetDungeonEquipRedDot Process")
  end
  ;
  ((NekoData.DataManager).DM_Dungeon):OnSGetDungeonEquipRedDot_LocalProtocol(self)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_DungeonEquipRedDot, self, nil)
end

return SGetDungeonEquipRedDot

