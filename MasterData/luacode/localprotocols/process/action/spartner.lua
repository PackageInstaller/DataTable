local SPartner = require("localprotocols.def.action.spartner")

function SPartner:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPartner Process")
  end
  if controller.OnSPartner then
    controller:OnSPartner(self)
  end
end

return SPartner
