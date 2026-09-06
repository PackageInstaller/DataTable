local SActorTimeSkillState = require("localprotocols.def.action.sactortimeskillstate")

function SActorTimeSkillState:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SActorTimeSkillState Process")
  end
  if controller.OnSActorTimeSkillState then
    controller:OnSActorTimeSkillState(self)
  end
end

return SActorTimeSkillState
