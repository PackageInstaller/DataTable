local SSkillPowerCost = require("localprotocols.def.action.sskillpowercost")

function SSkillPowerCost:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillPowerCost Process")
  end
  if controller.OnSSkillPowerCost then
    controller:OnSSkillPowerCost(self)
  end
end

return SSkillPowerCost
