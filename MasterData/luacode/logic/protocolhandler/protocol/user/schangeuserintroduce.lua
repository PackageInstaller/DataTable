local function p1(protocol)
  DialogManager.DestroySingletonDialog("systemsetting.introductiondialog")
  
  NekoData.DataManager.DM_Game:OnSChangeUserIntroduce(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ChangeUserIntroduce, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
