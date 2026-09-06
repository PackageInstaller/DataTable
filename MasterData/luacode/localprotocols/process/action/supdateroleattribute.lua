local SUpdateRoleAttribute = require("localprotocols.def.action.supdateroleattribute")

function SUpdateRoleAttribute:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateRoleAttribute Process")
  end
  if controller.OnSUpdateRoleAttribute then
    controller:OnSUpdateRoleAttribute(self)
  end
end

return SUpdateRoleAttribute
