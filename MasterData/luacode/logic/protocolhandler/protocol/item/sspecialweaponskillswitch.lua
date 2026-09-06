local function p1(protocol)
  LogInfoFormat("SSpecialWeaponSkillSwitch", "roleId = %s, skillOpen = %s", protocol.roleId, protocol.skillOpen)
  
  NekoData.DataManager.DM_AllRoles:OnSSpecialWeaponSkillSwitch(protocol)
  local dialog = DialogManager.GetDialog("uniqueequip.uniqueequipdialog")
  if dialog then
    dialog:RefreshSkillOpenByProtocol(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
