-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/ssignactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = ""
  for i,v in ipairs(protocol.awards) do
    local str_1 = "{itemId = " .. tostring(v.itemId) .. ", itemNum = " .. tostring(v.itemNum) .. ", receive = " .. tostring(v.receive) .. "}"
    if i ~= 1 then
      str_1 = "," .. str_1
    end
    str = str .. str_1
  end
  LogInfoFormat("ssignactivity", "-- actId = %s, deadline = %s, totalSignNum = %s, awardsStatus = %s", protocol.actId, protocol.deadline, protocol.totalSignNum, str)
  ;
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SignManagerID)):OnSSignActivity(protocol)
  ;
  ((NekoData.DataManager).DM_Activity):OnActivityStart(protocol.actId, protocol.deadline)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshSignActivity, nil, protocol.actId)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

