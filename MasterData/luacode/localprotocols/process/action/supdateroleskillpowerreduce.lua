local SUpdateRoleSkillPowerReduce = require("localprotocols.def.action.supdateroleskillpowerreduce")

function SUpdateRoleSkillPowerReduce:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateRoleSkillPowerReduce Process")
  end
  if controller.OnSUpdateRoleSkillPowerReduce then
    controller:OnSUpdateRoleSkillPowerReduce(self)
  end
end

return SUpdateRoleSkillPowerReduce
