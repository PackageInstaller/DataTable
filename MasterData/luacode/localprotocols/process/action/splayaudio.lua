local SPlayAudio = require("localprotocols.def.action.splayaudio")

function SPlayAudio:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPlayAudio Process")
  end
  if controller.OnSPlayAudio then
    controller:OnSPlayAudio(self)
  end
end

return SPlayAudio
