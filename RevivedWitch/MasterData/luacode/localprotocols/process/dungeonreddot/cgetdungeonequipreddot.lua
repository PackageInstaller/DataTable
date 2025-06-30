-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/dungeonreddot/cgetdungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGetDungeonEquipRedDot = require("localprotocols.def.dungeonreddot.cgetdungeonequipreddot")
CGetDungeonEquipRedDot.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CGetDungeonEquipRedDot Process")
  end
  ;
  (SqlConnection.GetDungeonEquipRedDotKey)(self.clientId)
end

return CGetDungeonEquipRedDot

