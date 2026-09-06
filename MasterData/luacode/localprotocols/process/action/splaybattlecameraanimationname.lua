local SPlayBattleCameraAnimationName = require("localprotocols.def.action.splaybattlecameraanimationname")

function SPlayBattleCameraAnimationName:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPlayBattleCameraAnimationName Process")
  end
  if controller.OnSPlayBattleCameraAnimationName then
    controller:OnSPlayBattleCameraAnimationName(self)
  end
end

return SPlayBattleCameraAnimationName
