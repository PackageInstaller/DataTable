local SSkillFail = require("localprotocols.def.action.sskillfail")

function SSkillFail:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillFail Process")
  end
  if controller.OnSSkillFail then
    controller:OnSSkillFail(self)
  end
end

return SSkillFail
