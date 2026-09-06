local function p1(protocol)
  local lastLevel = NekoData.BehaviorManager.BM_Alchemy:GetAlchemyLevel()
  
  NekoData.DataManager.DM_Alchemy:OnSAlchemyRankLevelUp(protocol)
  DialogManager.CreateSingletonDialog("alchemy.alchemylevelupdialog"):SetAlchemyLevel(lastLevel, protocol.level)
  LuaNotificationCenter.PostNotification(Common.n_RefreshAlchemy, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
