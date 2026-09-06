local function p1(protocol)
  DialogManager.DestroySingletonDialog("systemsetting.editheaddialog")
  
  NekoData.DataManager.DM_Game:OnSChangeUserFrame(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ChangeUserHeadFrame, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
