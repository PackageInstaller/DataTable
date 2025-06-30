-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sactionwithactiveskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SActionWithActiveSkill = require("localprotocols.def.action.sactionwithactiveskill")
SActionWithActiveSkill.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SActionWithActiveSkill Process")
  end
  if controller.OnSSActionWithActiveSkill then
    controller:OnSSActionWithActiveSkill(self)
  end
end

return SActionWithActiveSkill

