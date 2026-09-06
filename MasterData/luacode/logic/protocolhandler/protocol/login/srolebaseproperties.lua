local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleBaseProperties(protocol)
  
  local characterInfoDialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if characterInfoDialog then
    characterInfoDialog:OnRefresh()
  end
  local dialog = DialogManager.GetDialog("character.quicklevelup.quicklevelupmaindialog")
  if dialog and dialog._role and protocol.roleId == dialog._role:GetRoleId() then
    dialog:OnRefresh()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
