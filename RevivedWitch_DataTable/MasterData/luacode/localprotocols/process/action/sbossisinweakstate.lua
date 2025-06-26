-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbossisinweakstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBossIsInWeakState = require("localprotocols.def.action.sbossisinweakstate")
SBossIsInWeakState.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBossIsInWeakState Process")
  end
  if controller.OnSBossIsInWeakState then
    controller:OnSBossIsInWeakState(self)
  end
end

return SBossIsInWeakState

