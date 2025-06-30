-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshcaverntaskactive.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local slot = ((NekoData.BehaviorManager).BM_Explore):GetSlotInfoBySlotId((protocol.cavernTask).Id)
  if slot then
    for i,v in ipairs(slot.roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v, buildingId = nil})
    end
  end
  do
    ;
    ((NekoData.DataManager).DM_Explore):OnSRefreshCavernTaskActive(protocol)
    for i,v in ipairs((protocol.cavernTask).roles) do
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v.roleId, buildingId = DataCommon.Explore})
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshTimesChanged, nil, protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshExploreSlotActive, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

