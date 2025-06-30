-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshcavern.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local level = ((NekoData.BehaviorManager).BM_Explore):GetLevel()
  if level == 0 and (protocol.cavern).level == 1 then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingUnlock, nil, {buildingId = DataCommon.Explore})
  end
  local roles = ((NekoData.BehaviorManager).BM_Explore):GetRoles()
  for k,v in pairs(roles) do
    ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = k, buildingId = nil})
  end
  ;
  ((NekoData.DataManager).DM_Explore):OnSRefreshCavern(protocol)
  for k,v in pairs((protocol.cavern).tasks) do
    for i,roleInfo in ipairs(v.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleInfo.roleId, buildingId = DataCommon.Explore})
    end
  end
  if level < (protocol.cavern).level then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingLevelUp, nil, {buildingId = DataCommon.Explore})
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshAllExploreSlots, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

