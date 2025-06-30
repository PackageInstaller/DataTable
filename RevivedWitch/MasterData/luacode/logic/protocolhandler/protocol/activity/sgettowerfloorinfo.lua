-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sgettowerfloorinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local auto_changed = protocol.autoExploreState == 1 ~= ((NekoData.BehaviorManager).BM_TowerV2):IsInAutoExplore()
  ;
  ((NekoData.DataManager).DM_TowerV2):OnSGetTowerFloorInfo(protocol)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if not controller then
    GlobalGameFSM:SetNumber("sceneLoadingId", 30014)
  end
  if auto_changed then
    (LuaNotificationCenter.PostNotification)(Common.n_TowerV2AutoExplore, nil, protocol)
  end
  if protocol.autoExploreState == 1 then
    ((NekoData.DataManager).DM_Dungeon):SetMode("auto")
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TowerV2Refresh, nil, protocol)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

