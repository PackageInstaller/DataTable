-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/schangeequipment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSChangeEquipment(protocol)
  ;
  ((NekoData.DataManager).DM_BagInfo):OnSChangeEquipment(protocol)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller then
    ((NekoData.DataManager).DM_Dungeon):OnSChangeEquipment(protocol)
  end
  local userInfo = {}
  userInfo.name = "schangeequipment"
  userInfo.data = protocol
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleInfoChange, nil, userInfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_EquipChanged, nil, userInfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

