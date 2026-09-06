local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSPlayerLevelUp(protocol)
  
  DialogManager.CreateSingletonDialog("base.playerlevelupdialog"):SetData(protocol)
  LuaNotificationCenter.PostNotification(Common.n_StrengthLimitChanged, nil, nil)
  LuaNotificationCenter.PostNotification(Common.n_OnRefreshOldPlayerBenefits, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
