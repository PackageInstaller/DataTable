local function p1(protocol)
  local str = ""
  
  for i, v in ipairs(protocol.awards) do
    local str_1 = "{itemId = " .. tostring(v.itemId) .. ", itemNum = " .. tostring(v.itemNum) .. ", receive = " .. tostring(v.receive) .. "}"
    if i ~= 1 then
      str_1 = "," .. str_1
    end
    str = str .. str_1
  end
  LogInfoFormat("ssignactivity", "-- actId = %s, deadline = %s, totalSignNum = %s, awardsStatus = %s", protocol.actId, protocol.deadline, protocol.totalSignNum, str)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SignManagerID):OnSSignActivity(protocol)
  NekoData.DataManager.DM_Activity:OnActivityStart(protocol.actId, protocol.deadline)
  LuaNotificationCenter.PostNotification(Common.n_RefreshSignActivity, nil, protocol.actId)
end

local function p2(protocol, client)
end

return {p1, p2}
