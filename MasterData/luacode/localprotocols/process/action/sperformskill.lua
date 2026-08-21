-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sperformskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPerformSkill = require("localprotocols.def.action.sperformskill")
SPerformSkill.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPerformSkill Process")
  end
  if controller.OnSPerformSkill then
    controller:OnSPerformSkill(self)
  end
end

return SPerformSkill

