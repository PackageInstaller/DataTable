-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/schangeanimatorstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SChangeAnimatorState = require("localprotocols.def.action.schangeanimatorstate")
SChangeAnimatorState.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SChangeAnimatorState Process")
  end
  if controller.OnSChangeAnimatorState then
    controller:OnSChangeAnimatorState(self)
  end
end

return SChangeAnimatorState

