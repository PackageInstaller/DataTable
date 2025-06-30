-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sopendungeonbox.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local object = (controller:GetPathResolver()):GetChest(protocol.boxId)
  object:Open(protocol)
  local randomKey = ((NekoData.BehaviorManager).BM_Team):GetRandomRoleKeyInCurrentTeam()
  local roleID = randomKey
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OpenOneChestYeah, nil, {boxId = protocol.boxId})
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

