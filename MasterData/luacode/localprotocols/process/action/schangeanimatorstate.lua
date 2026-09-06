local SChangeAnimatorState = require("localprotocols.def.action.schangeanimatorstate")

function SChangeAnimatorState:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SChangeAnimatorState Process")
  end
  if controller.OnSChangeAnimatorState then
    controller:OnSChangeAnimatorState(self)
  end
end

return SChangeAnimatorState
