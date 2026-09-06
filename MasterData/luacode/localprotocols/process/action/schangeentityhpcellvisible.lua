local SChangeEntityHpCellVisible = require("localprotocols.def.action.schangeentityhpcellvisible")

function SChangeEntityHpCellVisible:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SChangeEntityHpCellVisible Process")
  end
  if controller.OnSChangeEntityHpCellVisible then
    controller:OnSChangeEntityHpCellVisible(self)
  end
end

return SChangeEntityHpCellVisible
