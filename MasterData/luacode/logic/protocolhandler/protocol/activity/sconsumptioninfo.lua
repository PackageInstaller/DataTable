local function p1(protocol)
  local str = ""
  
  for k, v in pairs(protocol.awardStatus) do
    if str ~= "" then
      str = str .. ", "
    end
    local awardStr = ""
    for i, item in ipairs(v.awards) do
      if awardStr ~= "" then
        awardStr = awardStr .. ","
      end
      awardStr = awardStr .. "[itemId=" .. item.itemId .. ", itemNum=" .. item.itemNum .. "]"
    end
    str = str .. "{id=" .. k .. ", status=" .. v.status .. ", awards=" .. awardStr .. "}"
  end
  LogInfoFormat("sconsumptioninfo", "--- activityId = %s, consumption = %s, awardStatus = %s ---", protocol.activityId, protocol.consumption, str)
  NekoData.DataManager.DM_Welfare:OnSconsumptionInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshAccumulateCost, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
