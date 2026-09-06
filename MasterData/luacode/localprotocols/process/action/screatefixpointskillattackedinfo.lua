local SCreateFixPointSkillAttackedInfo = require("localprotocols.def.action.screatefixpointskillattackedinfo")

function SCreateFixPointSkillAttackedInfo:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCreateFixPointSkillAttackedInfo Process")
  end
  if controller.OnSCreateFixPointSkillAttackedInfo then
    controller:OnSCreateFixPointSkillAttackedInfo(self)
  end
end

return SCreateFixPointSkillAttackedInfo
