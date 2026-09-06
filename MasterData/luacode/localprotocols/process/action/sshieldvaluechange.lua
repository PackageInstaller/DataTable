local SShieldValueChange = require("localprotocols.def.action.sshieldvaluechange")

function SShieldValueChange:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SShieldValueChange Process")
  end
  if controller.OnSShieldValueChange then
    controller:OnSShieldValueChange(self)
  end
end

return SShieldValueChange
