local SBattlePause = require("localprotocols.def.action.sbattlepause")

function SBattlePause:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattlePause Process")
  end
  if controller.OnSBattlePause then
    controller:OnSBattlePause(self)
  end
end

return SBattlePause
