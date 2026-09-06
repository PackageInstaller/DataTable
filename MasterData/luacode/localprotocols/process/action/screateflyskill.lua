local SCreateFlySkill = require("localprotocols.def.action.screateflyskill")

function SCreateFlySkill:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCreateFlySkill Process")
  end
  if controller.OnSCreateFlySkill then
    controller:OnSCreateFlySkill(self)
  end
end

return SCreateFlySkill
