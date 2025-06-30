-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/smainlinerewardrefreshed.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Task):OnSMainLineRewardRefreshed(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshMainLineTaskStatus, nil, protocol)
  local str = ""
  for i,v in ipairs(protocol.mainLineRewardStates) do
    if str ~= "" then
      str = str .. ", {id=" .. v.mainLineId .. ", status=" .. v.mainLineState .. "}"
    else
      str = str .. "{id=" .. v.mainLineId .. ", status=" .. v.mainLineState .. "}"
    end
  end
  LogInfoFormat("smainlinerewardrefreshed", "%s", str)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

