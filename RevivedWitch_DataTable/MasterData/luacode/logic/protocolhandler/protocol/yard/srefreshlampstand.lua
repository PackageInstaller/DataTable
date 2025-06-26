-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshlampstand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local level = ((NekoData.BehaviorManager).BM_Firefly):GetLevel()
  if level == 0 and (protocol.lampStand).level == 1 then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingUnlock, nil, {buildingId = DataCommon.Firefly})
  end
  ;
  ((NekoData.DataManager).DM_Currency):OnSRefreshLampStand(protocol)
  ;
  ((NekoData.DataManager).DM_Firefly):OnSRefreshLampStand(protocol)
  if level < (protocol.lampStand).level then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingLevelUp, nil, {buildingId = DataCommon.Firefly})
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshFirefly, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

