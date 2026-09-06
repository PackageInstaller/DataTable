local SSkillInterrupted = require("localprotocols.def.action.sskillinterrupted")

function SSkillInterrupted:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillInterrupted Process")
  end
  if controller.OnSSkillInterrupted then
    controller:OnSSkillInterrupted(self)
  end
end

return SSkillInterrupted
