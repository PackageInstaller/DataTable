-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sactiveskillstatechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SActiveSkillStateChange = require("localprotocols.def.action.sactiveskillstatechange")
SActiveSkillStateChange.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SActiveSkillStateChange Process")
  end
  if controller.OnSActiveSkillStateChange then
    controller:OnSActiveSkillStateChange(self)
  end
end

return SActiveSkillStateChange

