-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbattleworldpowershow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattleWorldPowerShow = require("localprotocols.def.action.sbattleworldpowershow")
SBattleWorldPowerShow.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattleWorldPowerShow Process")
  end
  if controller.OnSBattleWorldPowerShow then
    controller:OnSBattleWorldPowerShow(self)
  end
end

return SBattleWorldPowerShow

