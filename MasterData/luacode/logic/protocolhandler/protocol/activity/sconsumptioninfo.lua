-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sconsumptioninfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = ""
  for k,v in pairs(protocol.awardStatus) do
    if str ~= "" then
      str = str .. ", "
    end
    local awardStr = ""
    for i,item in ipairs(v.awards) do
      if awardStr ~= "" then
        awardStr = awardStr .. ","
      end
      awardStr = awardStr .. "[itemId=" .. item.itemId .. ", itemNum=" .. item.itemNum .. "]"
    end
    str = str .. "{id=" .. k .. ", status=" .. v.status .. ", awards=" .. awardStr .. "}"
  end
  LogInfoFormat("sconsumptioninfo", "--- activityId = %s, consumption = %s, awardStatus = %s ---", protocol.activityId, protocol.consumption, str)
  ;
  ((NekoData.DataManager).DM_Welfare):OnSconsumptionInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshAccumulateCost, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

