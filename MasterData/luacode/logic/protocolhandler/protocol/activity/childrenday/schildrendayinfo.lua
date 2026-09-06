local function p1(protocol)
  if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChildrenActivityManagerID):IsInit() then
    local protocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
    
    local activityIDForTask = protocol.CHILDREN_DAY
    if protocol then
      protocol.activityID = activityIDForTask
      protocol:Send()
    end
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    protocol.shopId = DataCommon.ChildrenActivity.Shop.ShopID
    protocol:Send()
  end
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChildrenActivityManagerID):OnClientGetInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SRefreshChildrenInfo, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
