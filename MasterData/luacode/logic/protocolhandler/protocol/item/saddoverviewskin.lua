local function p1(protocol)
  NekoData.DataManager.DM_SkinList:OnSAddOverviewSkin(protocol)
  
  local dialog = DialogManager.GetDialog("shop.roleskinlist.roleskinlistmaindialog")
  if dialog then
    dialog:SendUnLockSkin(protocol.skinId)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
