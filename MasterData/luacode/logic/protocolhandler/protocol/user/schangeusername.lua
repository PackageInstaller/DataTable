local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSChangeUserName(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_UserNameChanged, nil, protocol)
  local dialog = DialogManager.GetDialog("systemsetting.changenamedialog")
  if dialog then
    DialogManager.DestroySingletonDialog("systemsetting.changenamedialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
