-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sopenchristmassupportactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  dm:OnSOpenChristmasSupportActivity(protocol)
  if protocol.state == 0 then
    (LuaNotificationCenter.PostNotification)(Common.n_OnSChristmasSupportActivityEnd, nil, protocol)
  else
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSOpenChristmasSupportActivity, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

