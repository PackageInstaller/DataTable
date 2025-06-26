-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/scollaborativeskillnumchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCollaborativeSkillNumChange = require("localprotocols.def.action.scollaborativeskillnumchange")
SCollaborativeSkillNumChange.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCollaborativeSkillNumChange Process")
  end
  if controller.OnSCollaborativeSkillNumChange then
    controller:OnSCollaborativeSkillNumChange(self)
  end
end

return SCollaborativeSkillNumChange

