-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/staskfinishprogress.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local str = nil
  for k,v in pairs(protocol.tasks) do
    if not str then
      str = "{"
    else
      str = str .. ", "
    end
    str = str .. "[" .. k .. "] = " .. "{status = " .. v.status .. ", num = " .. v.num .. "}"
  end
  if str then
    str = str .. "}"
  end
  LogInfoFormat("staskfinishprogress", "--- tasks = %s, firstDrama = %s ---", str, protocol.firstDrama)
  ;
  ((NekoData.DataManager).DM_Anniversary):OnSTaskFinishProgress(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshAnniversaryCumulativeTask, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

