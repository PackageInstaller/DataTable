local SPartnerCreate = require("localprotocols.def.action.spartnercreate")

function SPartnerCreate:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPartnerCreate Process")
  end
  controller:OnSPartnerCreate(self)
end

return SPartnerCreate
