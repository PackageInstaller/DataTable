-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sadditem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_BagInfo):OnSAddItem(protocol)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller then
    ((NekoData.DataManager).DM_Dungeon):OnSAddItem(protocol)
  end
  if ((NekoData.DataManager).DM_AllRoles):CheckShowRoleEvolutionRed(protocol) then
    ((NekoData.BehaviorManager).BM_AllRoles):PostRoleEvolutionRedDataNotification()
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ItemAdd, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

