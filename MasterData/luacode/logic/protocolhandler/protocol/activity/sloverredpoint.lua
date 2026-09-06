local SLoverRedPoint = LuaNetManager.GetProtocolDef("protocol.activity.sloverredpoint")

local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.LoverActivityManagerID):OnSLoverRedPoint(protocol)
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID)
  if protocol.state == SLoverRedPoint.LOVER_CHOCOLATE then
    LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, bm.RedPointKey.Chocolate)
  elseif protocol.state == SLoverRedPoint.LOVER_FLOWER then
    LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, bm.RedPointKey.Flower)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
