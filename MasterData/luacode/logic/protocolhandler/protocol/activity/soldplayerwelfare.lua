local function p1(protocol)
  NekoData.DataManager.DM_Welfare:OnSOldPlayerWelfare(protocol)
  
  local str = ""
  for i, v in ipairs(protocol.commonReceiveList) do
    local str_1 = tostring(v)
    if i ~= 1 then
      str_1 = "," .. str_1
    end
    str = str .. str_1
  end
  LogInfoFormat("DM_Welfare", "soldplayerwelfare.commonReceiveList:%s", str)
  str = ""
  for i, v in ipairs(protocol.highReceiveList) do
    local str_1 = tostring(v)
    if i ~= 1 then
      str_1 = "," .. str_1
    end
    str = str .. str_1
  end
  LogInfoFormat("DM_Welfare", "soldplayerwelfare.highReceiveList:%s", str)
  LogInfoFormat("DM_Welfare", "soldplayerwelfare.totalNum:%s, isPay:%s", protocol.totalSignNum, protocol.isPay)
  LuaNotificationCenter.PostNotification(Common.n_OnRefreshOldPlayerBenefits, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
