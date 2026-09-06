local SDestroyEffectByName = require("localprotocols.def.action.sdestroyeffectbyname")

function SDestroyEffectByName:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDestroyEffectByName Process")
  end
  if controller.OnSDestroyEffectByName then
    controller:OnSDestroyEffectByName(self)
  end
end

return SDestroyEffectByName
