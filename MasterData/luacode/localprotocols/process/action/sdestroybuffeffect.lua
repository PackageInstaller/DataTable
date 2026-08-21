-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sdestroybuffeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDestroyBuffEffect = require("localprotocols.def.action.sdestroybuffeffect")
SDestroyBuffEffect.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDestroyBuffEffect Process")
  end
  if controller.OnSDestroyBuffEffect then
    controller:OnSDestroyBuffEffect(self)
  end
end

return SDestroyBuffEffect

