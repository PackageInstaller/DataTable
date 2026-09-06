local SActiveSkillStateChange = require("localprotocols.def.action.sactiveskillstatechange")

function SActiveSkillStateChange:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SActiveSkillStateChange Process")
  end
  if controller.OnSActiveSkillStateChange then
    controller:OnSActiveSkillStateChange(self)
  end
end

return SActiveSkillStateChange
