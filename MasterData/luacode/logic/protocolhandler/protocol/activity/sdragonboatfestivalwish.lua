local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  dm:OnSDragonBoatFestivalWish(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SDragonBoatFestivalWish, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
