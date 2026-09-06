local SCreateSceneEffect = require("localprotocols.def.action.screatesceneeffect")

function SCreateSceneEffect:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCreateSceneEffect Process")
  end
  if controller.OnSCreateSceneEffect then
    controller:OnSCreateSceneEffect(self)
  end
end

return SCreateSceneEffect
