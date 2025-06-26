-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/schangerougetowerautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_TowerV2):OnSChangeRougeTowerAutoExplore(protocol)
  local mode = nil
  if protocol.switchState == 1 then
    mode = "auto"
  end
  ;
  ((NekoData.DataManager).DM_Dungeon):SetMode(mode)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TowerV2AutoExplore, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

