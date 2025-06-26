-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sroleiscanuseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleIsCanUseSKill = require("localprotocols.def.action.sroleiscanuseskill")
SRoleIsCanUseSKill.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleIsCanUseSKill Process")
  end
  if controller.OnSRoleIsCanUseSKill then
    controller:OnSRoleIsCanUseSKill(self)
  end
end

return SRoleIsCanUseSKill

