local SActionWithActiveSkill = require("localprotocols.def.action.sactionwithactiveskill")

function SActionWithActiveSkill:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SActionWithActiveSkill Process")
  end
  if controller.OnSSActionWithActiveSkill then
    controller:OnSSActionWithActiveSkill(self)
  end
end

return SActionWithActiveSkill
