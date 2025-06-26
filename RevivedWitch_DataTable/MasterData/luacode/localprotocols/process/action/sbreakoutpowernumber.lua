-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbreakoutpowernumber.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBreakOutPowerNumber = require("localprotocols.def.action.sbreakoutpowernumber")
SBreakOutPowerNumber.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBreakOutPowerNumber Process")
  end
  if controller.OnSBreakOutPowerNumber then
    controller:OnSBreakOutPowerNumber(self)
  end
end

return SBreakOutPowerNumber

