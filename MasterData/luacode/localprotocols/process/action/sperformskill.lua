local SPerformSkill = require("localprotocols.def.action.sperformskill")

function SPerformSkill:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPerformSkill Process")
  end
  if controller.OnSPerformSkill then
    controller:OnSPerformSkill(self)
  end
end

return SPerformSkill
