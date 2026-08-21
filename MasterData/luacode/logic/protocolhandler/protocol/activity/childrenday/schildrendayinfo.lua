-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/childrenday/schildrendayinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChildrenActivityManagerID)):IsInit() then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
    local activityIDForTask = protocol.CHILDREN_DAY
    if protocol then
      protocol.activityID = activityIDForTask
      protocol:Send()
    end
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    protocol.shopId = ((DataCommon.ChildrenActivity).Shop).ShopID
    protocol:Send()
  end
  do
    ;
    (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChildrenActivityManagerID)):OnClientGetInfo(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SRefreshChildrenInfo, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

