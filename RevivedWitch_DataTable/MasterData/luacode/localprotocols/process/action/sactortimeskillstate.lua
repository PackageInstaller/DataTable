-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sactortimeskillstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SActorTimeSkillState = require("localprotocols.def.action.sactortimeskillstate")
SActorTimeSkillState.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SActorTimeSkillState Process")
  end
  if controller.OnSActorTimeSkillState then
    controller:OnSActorTimeSkillState(self)
  end
end

return SActorTimeSkillState

