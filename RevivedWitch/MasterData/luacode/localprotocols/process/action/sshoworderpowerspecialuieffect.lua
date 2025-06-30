-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sshoworderpowerspecialuieffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SShowOrderPowerSpecialUIEffect = require("localprotocols.def.action.sshoworderpowerspecialuieffect")
SShowOrderPowerSpecialUIEffect.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SShowOrderPowerSpecialUIEffect Process")
  end
  if controller.OnSShowOrderPowerSpecialUIEffect then
    controller:OnSShowOrderPowerSpecialUIEffect(self)
  end
end

return SShowOrderPowerSpecialUIEffect

