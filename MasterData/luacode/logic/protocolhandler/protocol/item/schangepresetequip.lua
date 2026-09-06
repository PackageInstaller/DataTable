local function p1(protocol)
  LogInfoFormat("scancelpresetequip", "roleId:%s,equipType:%s,equipKey:%s", protocol.roleId, protocol.equipType, protocol.equipKey)
  
  NekoData.DataManager.DM_AllRoles:OnSChangePresetEquip(protocol)
  LuaNotificationCenter.PostNotification(Common.n_EquipPresetChanged, nil, nil)
  local dialog = DialogManager.GetDialog("equip.presetequipdialog")
  if dialog then
    DialogManager.DestroySingletonDialog("equip.equipchangenewdialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
