local CBreakOutPower = require("localprotocols.def.action.cbreakoutpower")

function CBreakOutPower:Process(battleWorld)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CBreakOutPower Process")
  end
  battleWorld:OnCBreakOutPower(self)
end

return CBreakOutPower
