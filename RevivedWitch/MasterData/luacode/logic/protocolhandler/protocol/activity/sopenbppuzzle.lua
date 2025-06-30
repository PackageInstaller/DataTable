-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sopenbppuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if PrintTable then
    PrintTable(protocol, 3, "sopenbppuzzle")
  end
  local dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  dm:OnSOpenBpPuzzle(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnSOpenBpPuzzle, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

