local function p1(protocol)
  for _, v in ipairs(protocol.roleId) do
    LogInfoFormat("scancelpresetequip", "roleId:%s,equipType:%s", v, protocol.equipType)
  end
  NekoData.DataManager.DM_AllRoles:OnSCancelPresetEquip(protocol)
  LuaNotificationCenter.PostNotification(Common.n_EquipPresetChanged, nil, nil)
  local dialog = DialogManager.GetDialog("equip.presetequipdialog")
  local dialog1 = DialogManager.GetDialog("equip.equipresolvedialog")
  if dialog and not dialog1 then
    DialogManager.DestroySingletonDialog("equip.equipchangenewdialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
