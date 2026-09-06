local function p1(protocol)
  DialogManager.DestroySingletonDialog("systemsetting.editheaddialog")
  
  NekoData.DataManager.DM_Game:OnSChangeUserAvatar(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ChangeUserHeadPhoto, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
