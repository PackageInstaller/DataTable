local SChangeEntityName = require("localprotocols.def.action.schangeentityname")

function SChangeEntityName:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SChangeEntityName Process")
  end
  if controller.OnSChangeEntityName then
    controller:OnSChangeEntityName(self)
  end
end

return SChangeEntityName
