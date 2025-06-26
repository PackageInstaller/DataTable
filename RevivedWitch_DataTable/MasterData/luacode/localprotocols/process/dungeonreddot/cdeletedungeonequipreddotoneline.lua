-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/dungeonreddot/cdeletedungeonequipreddotoneline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDeleteDungeonEquipRedDotOneLine = require("localprotocols.def.dungeonreddot.cdeletedungeonequipreddotoneline")
CDeleteDungeonEquipRedDotOneLine.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CDeleteDungeonEquipRedDotOneLine Process")
  end
  ;
  (SqlConnection.DeleteOneLineDungeonEquipRedDotKey)(self.clientId, self.roleKey, self.equipKey)
end

return CDeleteDungeonEquipRedDotOneLine

