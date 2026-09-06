local function p1(protocol)
  LogInfoFormat("SGetSpecialWeaponInfo", "skillOpen = %s", protocol.skillOpen)
  
  NekoData.DataManager.DM_AllRoles:OnSGetSpecialWeaponInfo(protocol)
  local dialog = DialogManager.GetDialog("uniqueequip.uniqueequipdialog")
  if dialog then
    dialog:RefreshByProtocol(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
