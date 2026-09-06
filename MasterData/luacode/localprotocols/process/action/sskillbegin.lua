local SSkillBegin = require("localprotocols.def.action.sskillbegin")

function SSkillBegin:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillBegin Process")
  end
  if controller.OnSSkillBegin then
    controller:OnSSkillBegin(self)
  end
end

return SSkillBegin
