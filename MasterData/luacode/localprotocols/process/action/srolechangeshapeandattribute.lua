local SRoleChangeShapeAndAttribute = require("localprotocols.def.action.srolechangeshapeandattribute")

function SRoleChangeShapeAndAttribute:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleChangeShapeAndAttribute Process")
  end
  if controller.OnSRoleChangeShapeAndAttribute then
    controller:OnSRoleChangeShapeAndAttribute(self)
  end
end

return SRoleChangeShapeAndAttribute
