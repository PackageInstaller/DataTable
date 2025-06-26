-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sinvinciblestatechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SInvincibleStateChange = require("localprotocols.def.action.sinvinciblestatechange")
SInvincibleStateChange.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SInvincibleStateChange Process")
  end
  if controller.OnSInvincibleStateChange then
    controller:OnSInvincibleStateChange(self)
  end
end

return SInvincibleStateChange

