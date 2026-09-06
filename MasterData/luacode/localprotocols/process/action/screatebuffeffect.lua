local SCreateBuffEffect = require("localprotocols.def.action.screatebuffeffect")

function SCreateBuffEffect:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCreateBuffEffect Process")
  end
  if controller.OnSCreateBuffEffect then
    controller:OnSCreateBuffEffect(self)
  end
end

return SCreateBuffEffect
