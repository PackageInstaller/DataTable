local function p1(protocol)
  NekoData.DataManager.DM_Firefly:OnSGlowwormCapacityLv(protocol)
  
  DialogManager.DestroySingletonDialog("firefly.fireflylevelupdialog")
  LuaNotificationCenter.PostNotification(Common.n_FireflyCapacityLvUp, nil, protocol)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100219)
end

local function p2(protocol, client)
end

return {p1, p2}
