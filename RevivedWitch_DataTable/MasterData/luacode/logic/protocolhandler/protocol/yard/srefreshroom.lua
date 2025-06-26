-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshroom.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  for k,v in pairs(((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()) do
    for i,v in ipairs(v.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v, buildingId = nil})
    end
  end
  for k,v in pairs((protocol.room).floors) do
    for roleKey,leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKey, buildingId = DataCommon.Cabin})
    end
  end
  local level = ((NekoData.BehaviorManager).BM_Cabin):GetLevel()
  if level == 0 and (protocol.room).level == 1 then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingUnlock, nil, {buildingId = DataCommon.Cabin})
  end
  ;
  ((NekoData.DataManager).DM_Cabin):OnSRefreshRoom(protocol)
  if level < (protocol.room).level then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingLevelUp, nil, {buildingId = DataCommon.Cabin})
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshCabin, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

