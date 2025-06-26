-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/screatefixpointskillattackedinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCreateFixPointSkillAttackedInfo = require("localprotocols.def.action.screatefixpointskillattackedinfo")
SCreateFixPointSkillAttackedInfo.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCreateFixPointSkillAttackedInfo Process")
  end
  if controller.OnSCreateFixPointSkillAttackedInfo then
    controller:OnSCreateFixPointSkillAttackedInfo(self)
  end
end

return SCreateFixPointSkillAttackedInfo

