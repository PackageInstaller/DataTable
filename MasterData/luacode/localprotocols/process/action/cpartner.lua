local CPartner = require("localprotocols.def.action.cpartner")

function CPartner:Process(battleWorld)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CPartner Process")
  end
  battleWorld:OnCPartner(self)
end

return CPartner
