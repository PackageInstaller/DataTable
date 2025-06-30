-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/syardinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local useEnergy = false
  ;
  ((NekoData.DataManager).DM_MagicTree):OnSYardInfo(protocol)
  ;
  ((NekoData.DataManager).DM_Explore):OnSYardInfo(protocol)
  for k,v in pairs((protocol.cavern).tasks) do
    for i,roleInfo in ipairs(v.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleInfo.roleId, buildingId = DataCommon.Explore})
    end
  end
  ;
  ((NekoData.DataManager).DM_Firefly):OnSYardInfo(protocol)
  ;
  ((NekoData.DataManager).DM_Alchemy):OnSYardInfo(protocol)
  useEnergy = false
  local roleKey = (protocol.alchemy).roleId
  if roleKey ~= 0 then
    ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKey, buildingId = DataCommon.Alchemy})
  end
  for k,v in pairs((protocol.room).floors) do
    for roleKey,leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleKey, buildingId = DataCommon.Cabin})
    end
  end
  ;
  ((NekoData.DataManager).DM_Cabin):OnSYardInfo(protocol)
  for i,v in ipairs((protocol.trainRoom).trainList) do
    if v.roleId ~= 0 then
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v.roleId, buildingId = DataCommon.TrainCamp})
    end
  end
  ;
  ((NekoData.DataManager).DM_TrainCamp):OnSYardInfo(protocol)
  ;
  ((NekoData.DataManager).DM_YardMusic):OnSYardInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshCourtYard, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

