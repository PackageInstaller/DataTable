-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sreceiveactivtyitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SReceiveActivtyItemDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sreceiveactivtyitem")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : SReceiveActivtyItemDef, _ENV
  if protocol.activityLineId == SReceiveActivtyItemDef.FOOLSDAY then
    (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)):OnSReceiveActivtyItem(protocol)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SReceiveActivtyItem, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

