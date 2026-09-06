local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSGetRoleSkin(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SGetFashion, nil, protocol)
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if dialog then
    dialog:RefreshFashionInfo()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
