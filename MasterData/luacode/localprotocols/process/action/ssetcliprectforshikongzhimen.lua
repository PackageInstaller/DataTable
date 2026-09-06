local SSetClipRectForShiKongZhiMen = require("localprotocols.def.action.ssetcliprectforshikongzhimen")

function SSetClipRectForShiKongZhiMen:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSetClipRectForShiKongZhiMen Process")
  end
  if controller.OnSSetClipRectForShiKongZhiMen then
    controller:OnSSetClipRectForShiKongZhiMen(self)
  end
end

return SSetClipRectForShiKongZhiMen
