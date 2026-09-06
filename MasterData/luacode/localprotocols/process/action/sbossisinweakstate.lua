local SBossIsInWeakState = require("localprotocols.def.action.sbossisinweakstate")

function SBossIsInWeakState:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBossIsInWeakState Process")
  end
  if controller.OnSBossIsInWeakState then
    controller:OnSBossIsInWeakState(self)
  end
end

return SBossIsInWeakState
