local function p1(protocol)
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  dm:OnSEchoShopRedPoint(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSEchoShopRedPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
