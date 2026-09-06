local SReceiveActivtyItemDef = LuaNetManager.GetProtocolDef("protocol.activity.sreceiveactivtyitem")

local function p1(protocol)
  if protocol.activityLineId == SReceiveActivtyItemDef.FOOLSDAY then
    NekoData.DataManager.DM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID):OnSReceiveActivtyItem(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_SReceiveActivtyItem, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
