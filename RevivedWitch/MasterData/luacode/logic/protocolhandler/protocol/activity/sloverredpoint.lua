-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sloverredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SLoverRedPoint = (LuaNetManager.GetProtocolDef)("protocol.activity.sloverredpoint")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, SLoverRedPoint
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.LoverActivityManagerID)):OnSLoverRedPoint(protocol)
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.LoverActivityManagerID)
  if protocol.state == SLoverRedPoint.LOVER_CHOCOLATE then
    (LuaNotificationCenter.PostNotification)(Common.n_LoverRefreshRedPoint, nil, (bm.RedPointKey).Chocolate)
  else
    if protocol.state == SLoverRedPoint.LOVER_FLOWER then
      (LuaNotificationCenter.PostNotification)(Common.n_LoverRefreshRedPoint, nil, (bm.RedPointKey).Flower)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

