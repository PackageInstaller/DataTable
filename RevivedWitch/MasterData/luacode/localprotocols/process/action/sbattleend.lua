-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattleEnd = require("localprotocols.def.action.sbattleend")
SBattleEnd.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattleEnd Process")
  end
  controller:OnSBattleEnd(self)
end

return SBattleEnd

