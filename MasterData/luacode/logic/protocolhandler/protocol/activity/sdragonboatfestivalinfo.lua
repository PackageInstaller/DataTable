local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  dm:OnSDragonBoatFestivalInfo(protocol)
  if bm:GetIsOpen() then
    bm:SendCDragonBoatFestivalWish()
  end
  LuaNotificationCenter.PostNotification(Common.n_SDragonBoatFestivalInfo, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
