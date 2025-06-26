-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sshieldvaluechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SShieldValueChange = require("localprotocols.def.action.sshieldvaluechange")
SShieldValueChange.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SShieldValueChange Process")
  end
  if controller.OnSShieldValueChange then
    controller:OnSShieldValueChange(self)
  end
end

return SShieldValueChange

