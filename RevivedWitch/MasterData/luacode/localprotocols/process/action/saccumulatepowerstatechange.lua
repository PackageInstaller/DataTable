-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/saccumulatepowerstatechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SAccumulatePowerStateChange = require("localprotocols.def.action.saccumulatepowerstatechange")
SAccumulatePowerStateChange.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SAccumulatePowerStateChange Process")
  end
  if controller.OnSAccumulatePowerStateChange then
    controller:OnSAccumulatePowerStateChange(self)
  end
end

return SAccumulatePowerStateChange

