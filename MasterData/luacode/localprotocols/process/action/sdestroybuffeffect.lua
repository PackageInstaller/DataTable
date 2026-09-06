local SDestroyBuffEffect = require("localprotocols.def.action.sdestroybuffeffect")

function SDestroyBuffEffect:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDestroyBuffEffect Process")
  end
  if controller.OnSDestroyBuffEffect then
    controller:OnSDestroyBuffEffect(self)
  end
end

return SDestroyBuffEffect
