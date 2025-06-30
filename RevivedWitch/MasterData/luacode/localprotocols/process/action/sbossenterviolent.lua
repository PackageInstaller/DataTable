-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbossenterviolent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBossEnterViolent = require("localprotocols.def.action.sbossenterviolent")
SBossEnterViolent.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBossEnterViolent Process")
  end
  if controller.OnSBossEnterViolent then
    controller:OnSBossEnterViolent(self)
  end
end

return SBossEnterViolent

