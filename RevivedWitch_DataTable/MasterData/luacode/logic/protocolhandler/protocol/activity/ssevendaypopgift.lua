-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/ssevendaypopgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local commonStr = ""
  for k,v in pairs(protocol.rewards) do
    if commonStr ~= "" then
      commonStr = commonStr .. ", "
    end
    commonStr = commonStr .. "{key=" .. k .. ", status=" .. v .. "}"
  end
  LogInfoFormat("SSevenDayPopGIft", "--- pop = %s, hasBought = %s, leftTime = %s, goodId = %s, rewards = %s ---", protocol.pop, protocol.hasBought, protocol.leftTime, protocol.goodId, commonStr)
  ;
  ((NekoData.DataManager).DM_Activity):OnSSevenDayPopGIft(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshPopUpGift7Day, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

