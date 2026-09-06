local TaskUIHandler = {}

function TaskUIHandler:Handle()
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID(9)
  local dialog = DialogManager.GetDialog("shop.shopmaindialog")
  if dialog then
    DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
  else
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
end

return TaskUIHandler
