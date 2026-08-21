-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/soldplayerwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Welfare):OnSOldPlayerWelfare(protocol)
  local str = ""
  for i,v in ipairs(protocol.commonReceiveList) do
    local str_1 = tostring(v)
    if i ~= 1 then
      str_1 = "," .. str_1
    end
    str = str .. str_1
  end
  LogInfoFormat("DM_Welfare", "soldplayerwelfare.commonReceiveList:%s", str)
  str = ""
  for i,v in ipairs(protocol.highReceiveList) do
    local str_1 = tostring(v)
    if i ~= 1 then
      str_1 = "," .. str_1
    end
    str = str .. str_1
  end
  LogInfoFormat("DM_Welfare", "soldplayerwelfare.highReceiveList:%s", str)
  LogInfoFormat("DM_Welfare", "soldplayerwelfare.totalNum:%s, isPay:%s", protocol.totalSignNum, protocol.isPay)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnRefreshOldPlayerBenefits, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

