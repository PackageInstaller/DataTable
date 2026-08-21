-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/dungeonreddot/cdeletedungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDeleteDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.cdeletedungeonequipreddot")
CDeleteDungeonEquipRedDot.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CDeleteDungeonEquipRedDot Process")
  end
  ;
  (SqlConnection.RemoveDungeonEquipRedDotKeyTable)(self.clientId)
end

return CDeleteDungeonEquipRedDot

