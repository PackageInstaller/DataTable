local function p1(protocol)
  NekoData.DataManager.DM_Tower:OnSIslandTouchAltar(protocol)
  
  DialogManager.DestroySingletonDialog("tower.towershrinedialog")
  NekoData.BehaviorManager.BM_Message:SendMessageById(100138)
  LuaNotificationCenter.PostNotification(Common.n_TowerShrineActivated, {}, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
