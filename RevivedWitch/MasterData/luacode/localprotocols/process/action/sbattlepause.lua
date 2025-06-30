-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbattlepause.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattlePause = require("localprotocols.def.action.sbattlepause")
SBattlePause.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattlePause Process")
  end
  if controller.OnSBattlePause then
    controller:OnSBattlePause(self)
  end
end

return SBattlePause

