local SUpdateBossHpStage = require("localprotocols.def.action.supdatebosshpstage")

function SUpdateBossHpStage:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateBossHpStage Process")
  end
  if controller.OnSUpdateBossHpStage then
    controller:OnSUpdateBossHpStage(self)
  end
end

return SUpdateBossHpStage
