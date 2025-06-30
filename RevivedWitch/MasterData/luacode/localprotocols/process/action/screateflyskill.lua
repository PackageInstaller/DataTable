-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/screateflyskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCreateFlySkill = require("localprotocols.def.action.screateflyskill")
SCreateFlySkill.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCreateFlySkill Process")
  end
  if controller.OnSCreateFlySkill then
    controller:OnSCreateFlySkill(self)
  end
end

return SCreateFlySkill

