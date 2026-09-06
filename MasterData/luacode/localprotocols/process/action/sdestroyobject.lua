local SDestroyObject = require("localprotocols.def.action.sdestroyobject")

function SDestroyObject:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDestroyObject Process")
  end
  controller:OnSDestroyObject(self)
end

return SDestroyObject
