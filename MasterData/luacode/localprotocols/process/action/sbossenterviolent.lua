local SBossEnterViolent = require("localprotocols.def.action.sbossenterviolent")

function SBossEnterViolent:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBossEnterViolent Process")
  end
  if controller.OnSBossEnterViolent then
    controller:OnSBossEnterViolent(self)
  end
end

return SBossEnterViolent
