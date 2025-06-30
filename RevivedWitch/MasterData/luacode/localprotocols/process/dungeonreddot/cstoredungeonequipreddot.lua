-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/dungeonreddot/cstoredungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStoreDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.cstoredungeonequipreddot")
CStoreDungeonEquipRedDot.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CStoreDungeonEquipRedDot Process")
  end
  ;
  (SqlConnection.StoreDungeonEquipRedDotKey)(self.clientId, self.redDotData)
end

return CStoreDungeonEquipRedDot

