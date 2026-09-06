local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID):OnSRefreshFoolsDayRoles(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
