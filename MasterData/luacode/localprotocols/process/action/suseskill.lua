local SUseSkill = require("localprotocols.def.action.suseskill")

function SUseSkill:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUseSkill Process")
  end
  if controller.OnSUseSkill then
    controller:OnSUseSkill(self)
  end
end

return SUseSkill
