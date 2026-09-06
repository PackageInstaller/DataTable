local SShowOrderPowerSpecialUIEffect = require("localprotocols.def.action.sshoworderpowerspecialuieffect")

function SShowOrderPowerSpecialUIEffect:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SShowOrderPowerSpecialUIEffect Process")
  end
  if controller.OnSShowOrderPowerSpecialUIEffect then
    controller:OnSShowOrderPowerSpecialUIEffect(self)
  end
end

return SShowOrderPowerSpecialUIEffect
