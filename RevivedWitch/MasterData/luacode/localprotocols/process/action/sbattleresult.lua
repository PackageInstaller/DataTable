-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbattleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattleResult = require("localprotocols.def.action.sbattleresult")
SBattleResult.Process = function(self, battleWorld)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattleResult Process")
  end
  if battleWorld.OnSBattleResult then
    battleWorld:OnSBattleResult(self)
  end
end

return SBattleResult

